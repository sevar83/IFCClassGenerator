inverseAttributeGetter(attribute) ::= <<
// INVERSE 
public $typeDecl(attribute.type.type)$ get$attribute.id$_Inverse()
{
	return ($typeDecl(attribute.type.type)$) getAttributeValue($publicAttributeName(attribute.id)$);
}

>>