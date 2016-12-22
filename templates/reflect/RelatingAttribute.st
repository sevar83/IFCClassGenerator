RelatingAttribute() ::= <<
$preamble()$

package $package_reflect()$;


public class RelatingAttribute extends RelationshipAttribute
{
	public RelatingAttribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{
		super(name, ownerType, isDemandedOrOptional);
	}
}
>>