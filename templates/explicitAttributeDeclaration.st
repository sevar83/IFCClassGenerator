explicitAttributeDeclaration(attribute) ::= <<
/* $optionalOrDemanded(attribute.optional)$ */ private $typeDecl(attribute.type.type)$ $privateAttributeName(attribute.id)$;
>>