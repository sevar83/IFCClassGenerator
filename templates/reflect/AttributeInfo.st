AttributeInfo() ::= <<
$preamble()$

package $package_reflect()$;


public interface AttributeInfo 
{
	public enum Type
	{
		ENTITY,
		ENUM,
		TYPE,
		SELECT,
		SIMPLE,
		AGGREGATION
	}
	
	public String getName();
	public Type getTypeCategory();
	public Class<?> getType();
	public Class<?> getOwnerClass();
	public boolean isDemanded();
	public boolean isOptional();
	public Object get(Object ownerInstance);
	public void set(Object ownerInstance, Object value);
}
>>