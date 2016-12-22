DerivedAttribute() ::= <<
$preamble()$

package $package_reflect()$;


public class DerivedAttribute extends MethodBasedAttribute
{
	public DerivedAttribute(String name, Class<?> ownerType)
	{
		super(name, ownerType, true);
	}

	@Override
	public void set(Object ownerInstance, Object value)
	{
		throw new IllegalStateException("Derived attributes are read-only");
	}
}
>>