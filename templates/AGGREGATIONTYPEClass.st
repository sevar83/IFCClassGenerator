AGGREGATIONTYPEClass(declType, aggId) ::= <<
$preamble()$

package $package()$;


@SuppressWarnings("unchecked")
public $class(declType)$ $extends(declType)$<$declType.underlyingType.baseType$> $implements_(declType, "Type")$
{
	public $declType.id$()
	{		
	}
	
	public $declType.id$($declType.superType.id$<$declType.underlyingType.baseType.id$> other)
	{
		setValue(other);
	}
	
	public void setValue(Object other) 
	{
		super.setValue(($declType.superType.id$<$declType.underlyingType.baseType.id$>) other);
	}
	
	@Override	
	public $declType.id$ clone()
	{
		$declType.id$ clone = ($declType.id$) super.clone();
		
		return clone;
	}
	
	public $declType.id$ shallowClone()
	{
		$declType.id$ clone = ($declType.id$) super.clone();

		return clone;
	}
}
>>