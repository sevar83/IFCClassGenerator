MethodBasedAttribute() ::= <<
$preamble()$

package $package_reflect()$;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;


public class MethodBasedAttribute extends Attribute
{
	private final Method underlyingGetter;
	private final Method underlyingSetter;
	
	public MethodBasedAttribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{
		super(name, ownerType, isDemandedOrOptional);
		
		Method method = null;
		String capitalizedName = capitalizeFirstLetter(name);
		
		// Search for an underlying getter-method by name
		try
		{
			method = getOwnerClass().getMethod("get" + capitalizedName);
			this.underlyingGetter = method;
			this.underlyingGetter.setAccessible(true);
		}
		catch (SecurityException ex)
		{
			throw new IllegalArgumentException("Restricted security access to Attribute: \"" + name + "\" in type: " + ownerType);
		}
		catch (NoSuchMethodException ex)
		{
			throw new IllegalArgumentException("Could not find underlying Method for Attribute: \"" + name + "\" in type: " + ownerType);
		}				
		
		// Search for an underlying setter-method by name
		method = null;
		try
		{
			method = getOwnerClass().getMethod("set" + capitalizedName, this.underlyingGetter.getReturnType());			
		}
		catch (SecurityException ex)
		{
			throw new IllegalArgumentException("Restricted security access to Attribute: \"" + name + "\" in type: " + ownerType);
		}
		catch (NoSuchMethodException ex)
		{
			// Read-only attribute
		}
		
		this.underlyingSetter = method;
		if (method != null)
			this.underlyingSetter.setAccessible(true);			
	}

	@Override
	public Type getTypeCategory()
	{
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Class<?> getType()
	{
		return this.underlyingGetter.getReturnType();
	}

	@Override
	public Object get(Object ownerInstance)
	{
		try
		{
			return this.underlyingGetter.invoke(ownerInstance);
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
		catch (InvocationTargetException ex)
		{
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
		return null;
	}

	@Override
	public void set(Object ownerInstance, Object value)
	{
		try
		{
			this.underlyingSetter.invoke(ownerInstance, value);
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
		catch (InvocationTargetException ex)
		{
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
	}
	
	protected String capitalizeFirstLetter(String string)
	{
		if (!string.isEmpty())
		{
			string = Character.toUpperCase(string.charAt(0)) + string.substring(1, string.length());
		}
		return string;
	}
}
>>