inverseAttributeDescription(attribute) ::= <<
public static final InverseAttribute $publicAttributeName(attribute.id)$ = new InverseAttribute("$privateAttributeName(attribute.id)$", $attribute.owner$.class, $attribute.baseType$.$publicAttributeName(attribute.forwardAttribute.id)$);
>>