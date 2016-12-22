RelationshipAttribute() ::= <<
$preamble()$

package $package_reflect()$;


public abstract class RelationshipAttribute extends DirectAttribute
{
	public RelationshipAttribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{
		super(name, ownerType, isDemandedOrOptional);
	}
}
>>