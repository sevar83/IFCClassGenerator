FieldBasedAttribute() ::= <<
$preamble()$

package $package_reflect()$;

import java.lang.reflect.Field;
import java.lang.UnsupportedOperationException;


public class FieldBasedAttribute extends Attribute
{
	private final Field associatedField;
	
	public FieldBasedAttribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{
		super(name, ownerType, isDemandedOrOptional);
		
		// Find the associated field by name
		try
		{
			this.associatedField = getOwnerClass().getDeclaredField(name);
			this.associatedField.setAccessible(true);
		}
		catch (SecurityException ex)
		{
			throw new IllegalArgumentException("Restricted security access to Attribute: \"" + name + "\" in type: " + ownerType);
		}
		catch (NoSuchFieldException ex)
		{
			throw new IllegalArgumentException("Could not find underlying Field Attribute: \"" + name + "\" in type: " + ownerType);
		}		
	}
	
	public Field getAssociatedField()
	{
		return this.associatedField;
	}
	
	public void set(Object ownerInstance, Object value)
	{
		try
		{
			this.associatedField.set(ownerInstance, value);
		}
		catch (IllegalArgumentException ex)
		{
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
		catch (IllegalAccessException ex)
		{
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
	}
	
	public Object get(Object ownerInstance)
	{
		try
		{
			return this.associatedField.get(ownerInstance);
		}
		catch (IllegalArgumentException ex)
		{
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
		catch (IllegalAccessException ex)
		{
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
		return null;
	}

	@Override
	public Type getTypeCategory()
	{
		throw new UnsupportedOperationException();
		//return null;
	}

	@Override
	public Class<?> getType()
	{
		return this.associatedField.getType();
	}
}
>>