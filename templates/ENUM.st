ENUM() ::= <<
$preamble()$

package $package()$;

public class ENUM implements IfcBaseInterface
{
	protected Enum<?> value;
	protected String stringValue;

	public ENUM()
	{
	}

	public ENUM(String stringValue)
	{
		this.stringValue = stringValue;
	}

	public ENUM(Enum<?> value)
	{
		this.value = value;
	}

	public void setValue(String value) 
	{

	}

	@Override
	public boolean equals(Object other)
	{
		if (!(other instanceof ENUM))
			return false;
		
		return this.value.equals(((ENUM) other).value);
	}
	
	public Object clone() 
	{
		ENUM clone = new ENUM(this.value);
		clone.stringValue = this.stringValue;
		return clone;
	}

	public String toString() 
	{
		return this.stringValue;
	}
}
>>