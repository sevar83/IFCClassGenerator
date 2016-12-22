explicitAttributeTypeId(attribute) ::= <<
$if(attribute.overridenId)$$attribute.overridenId$$else$DirectAttribute$endif$
>>