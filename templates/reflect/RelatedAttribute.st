RelatedAttribute() ::= <<
$preamble()$

package $package_reflect()$;


public class RelatedAttribute extends RelationshipAttribute
{
	public RelatedAttribute(String name, Class<?> ownerType, boolean isDemandedOrOptional)
	{
		super(name, ownerType, isDemandedOrOptional);
	}
}
>>