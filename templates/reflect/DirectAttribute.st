DirectAttribute() ::= <<
$preamble()$

package $package_reflect()$;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import $package()$.AggregationType;
import $package()$.IfcBaseInterface;
import $package()$.SET;


public class DirectAttribute extends FieldBasedAttribute
{	
	private Set<InverseAttribute> inverseAttributes;
	
	public DirectAttribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{
		super(name, ownerType, isDemandedOrOptional);		
	}
	
	public void set(Object ownerInstance, Object value)
	{
		// TODO: Do some type checking
		
		boolean isAggregation = Collection.class.isAssignableFrom(getType());
		
		if (isAggregation)
			syncInversesRemoveAll(ownerInstance, (Collection<IfcBaseInterface>) this.get(ownerInstance));
		else
			syncInversesRemove(ownerInstance, (IfcBaseInterface) this.get(ownerInstance));
		
		super.set(ownerInstance, value);
		
		if (isAggregation)
			syncInversesAddAll(ownerInstance, (Collection<IfcBaseInterface>) value);
		else
			syncInversesAdd(ownerInstance, (IfcBaseInterface) value);
	}
	
	public Object get(Object ownerInstance)
	{
		return super.get(ownerInstance); 
	}
	
	/**
	 * For internal use only
	 * 
	 * @return
	 */
	public Set<InverseAttribute> getInverses()
	{
		return this.inverseAttributes;
	}
	
	protected void addInverse(InverseAttribute inverseAttribute)
	{
		if (this.inverseAttributes == null)
			this.inverseAttributes = new HashSet<InverseAttribute>();
		this.inverseAttributes.add(inverseAttribute);
	}
	
	/**
	 *  For internal usage only
	 *  
	 * @param ownerInstance
	 * @param value
	 */
	public void syncInversesAdd(Object ownerInstance, IfcBaseInterface element)
	{
		Collection<InverseAttribute> inverses = getInverses();
		if (element != null && inverses != null)
		{
			for (InverseAttribute inverse : inverses)
			{
				// Check if this is the inverse that accepts this type of element
				if (inverse.getOwnerClass().isAssignableFrom(element.getClass()))
				{
					SET<IfcBaseInterface> attributeValue = (SET<IfcBaseInterface>) inverse.get(element);
					if (SET.class.isAssignableFrom(inverse.getType()))
					{
						if (attributeValue == null)
						{
							attributeValue = new SET<IfcBaseInterface>();
							inverse.set(element, attributeValue);
						}
						if (attributeValue.getHiIndex() == 1)
							attributeValue.clear();
						attributeValue.add((IfcBaseInterface) ownerInstance);
					}
					// TODO: implement BAG as inverse type, LIST and ARRAY are not allowed in EXPRESS spec.
					
					/*else if (LIST.class.isAssignableFrom(inverse.getType()))
					{
						((LIST) inverse).add(ownerInstance, element);
					}*/
					else
					{
						inverse.set(element, (IfcBaseInterface) ownerInstance);
					}
				}
			}
		}
	}
	
	/**
	 *  For internal usage only
	 *  
	 * @param ownerInstance
	 * @param value
	 */
	public void syncInversesAddAll(Object ownerInstance, Collection<IfcBaseInterface> elements)
	{
		if (elements != null)
		{
			for (IfcBaseInterface element : elements)
			{
				syncInversesAdd(ownerInstance, element);
			}
		}
	}
	
	/**
	 *  For internal usage only
	 */
	public void syncInversesRemove(Object ownerInstance, IfcBaseInterface element)
	{
		Collection<InverseAttribute> inverses = getInverses();
		if (element != null && inverses != null)
		{
			for (InverseAttribute inverse : inverses)
			{			
				// Check if this is the inverse that accepts this type of element
				if (inverse.getOwnerClass().isAssignableFrom(element.getClass()))
				{
					SET<IfcBaseInterface> attributeValue = (SET<IfcBaseInterface>) inverse.get(element);
					if (SET.class.isAssignableFrom(inverse.getType()))
					{
						((SET) attributeValue).remove((IfcBaseInterface) ownerInstance);
					}		
					// TODO: implement BAG as inverse type, LIST and ARRAY are not allowed in EXPRESS spec.
					
					/*else if (attributeValue instanceof LIST)
					{
						((LIST) inverse).remove(ownerInstance, element);
					}*/
					else
					{
						inverse.set(element, null);
					}
				} 
			}
		}
	}
	
	/**
	 *  For internal usage only
	 */
	public void syncInversesRemoveAll(Object ownerInstance, Collection<IfcBaseInterface> elements)
	{
		if (elements != null)
		{
			for (IfcBaseInterface element : elements)
			{
				syncInversesRemove(ownerInstance, element);
			}
		}
	}
}
>>