Attribute() ::= <<
$preamble()$

package $package_reflect()$;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeSet;

import $package_tools()$.CollectionUtils;
import $package_tools()$.predicates.Predicate;

public abstract class Attribute implements AttributeInfo, Comparable<Attribute>
{	
	private static long counter = 0;
	
	private final String name;
	private final Class<?> ownerType;
	private final boolean isDemandedOrOptional;	
	private final long globalNumber;
	
	// Map of IFC classes -> Map of attribute names -> attribute objects
	private static final Map<Class<?>, Map<String, Attribute\>\> ATTRIBUTES = new HashMap<Class<?>, Map<String, Attribute\>\>();
	private static final Map<Class<?>, SortedSet<Attribute\>\> SORTED_ATTRIBUTES = new HashMap<Class<?>, SortedSet<Attribute\>\>();
	
	/**
	 * Attribute constructor
	 * 
	 * @param name name of the attribute. Should be the same as the actual member variable containing the attribute
	 * @param ownerType class where this attribute is declared
	 * @param demandedOrOptional true if attribute is demanded, false if attribute is optional
	 */
	public Attribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{		
		if (name == null)
			throw new NullPointerException("Null name");		
		if (name.isEmpty())
			throw new IllegalArgumentException("Empty name");
		if (ownerType == null)
			throw new NullPointerException("Null owner type");
		
		// Check for duplicates
		if (Attribute.find(ownerType, name) != null)
			throw new IllegalArgumentException("Duplicating attribute: \"" + name + "\" in type: " + ownerType);
			
		this.name = name;
		this.ownerType = ownerType;
		this.isDemandedOrOptional = isDemandedOrOptional;
		this.globalNumber = counter++;
		
		Map<String, Attribute> attributesOfType = ATTRIBUTES.get(ownerType);
		if (attributesOfType == null)
		{
			attributesOfType = new HashMap<String, Attribute>();
			ATTRIBUTES.put(ownerType, attributesOfType);
		}
		
		SortedSet<Attribute> sortedAttributes = SORTED_ATTRIBUTES.get(ownerType);
		if (sortedAttributes == null)
		{
			sortedAttributes = new TreeSet<Attribute>();
			SORTED_ATTRIBUTES.put(ownerType, sortedAttributes);
		}
		
		attributesOfType.put(name, this);
		sortedAttributes.add(this);
	}
	
	@Override
	public String getName()
	{
		return this.name;
	}
	
	@Override
	public Class<?> getOwnerClass()
	{
		return this.ownerType;
	}
		
	@Override
	public boolean isDemanded()
	{
		return this.isDemandedOrOptional;
	}
	
	@Override
	public boolean isOptional()
	{
		return this.isDemandedOrOptional;
	}

	@Override
	public int compareTo(Attribute o)
	{
		return (int) (this.globalNumber - o.globalNumber);
	}

	public static Attribute find(Class<?> ownerType, String attributeName)
	{
		Map<String, Attribute> attributesOfType = ATTRIBUTES.get(ownerType);
		if (attributesOfType != null)
		{
			return attributesOfType.get(attributeName);
		}
		return null;
	}
	
	public static SortedSet<Attribute> find(Class<?> ownerType)
	{
		return SORTED_ATTRIBUTES.get(ownerType);
	}
	
	public static SortedSet<Attribute> find(Class<?> ownerType, Predicate predicate)
	{
		SortedSet<Attribute> attributesOfType = find(ownerType);		
		return (attributesOfType != null) ? new TreeSet<Attribute>(CollectionUtils.filter(attributesOfType, predicate)) : null;
	}
	
	@Override
	public String toString()
	{
		return getName();
	}
}
>>