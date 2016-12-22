InverseAttribute() ::= <<
$preamble()$

package $package_reflect()$;


public class InverseAttribute extends FieldBasedAttribute
{
	private final DirectAttribute directAttribute;
	
	public InverseAttribute(String name, Class<?> ownerType, DirectAttribute directAttribute)
	{
		super(name, ownerType, true);
		this.directAttribute = directAttribute;
		directAttribute.addInverse(this);
	}
	
	public DirectAttribute getDirectAttribute()
	{
		return this.directAttribute;
	}
}
>>