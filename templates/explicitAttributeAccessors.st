explicitAttributeAccessors(attribute) ::= <<
// $optionalOrDemanded(attribute.optional)$ 
public $typeDecl(attribute.type.type)$ get$attribute.id$()
{
	return ($typeDecl(attribute.type.type)$) getAttributeValue($publicAttributeName(attribute.id)$);
}

// $optionalOrDemanded(attribute.optional)$ 
public void set$attribute.id$($typeDecl(attribute.type.type)$ value)
{
	setAttributeValue($publicAttributeName(attribute.id)$, value);
}
>>