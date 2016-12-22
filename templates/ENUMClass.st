ENUMClass(declType) ::= <<
$preamble()$

package $package()$;

public class $declType.id$ extends ENUM implements Type
{
	public $declType.id$()
	{
	}

	public $declType.id$(java.lang.String value)
	{
		this.value = $declType.id$_internal.valueOf(value);
	}
	
	@Override
	public void setValue(Object value)
	{
		this.value = ($declType.id$_internal) value;
	}
	
	@Override
	public void setValue(java.lang.String value)
	{
		this.value = $declType.id$_internal.valueOf(value);
	}
	
	@Override
	public $declType.id$ clone()
	{		
		$declType.id$ clone = new $declType.id$();
		clone.setValue(this.value);
		return clone;
	}

	public enum $declType.id$_internal
	{
		$declType.underlyingType.ids; separator=",\n"$
	}
}
>>