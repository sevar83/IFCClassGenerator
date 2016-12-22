implements_(type, mandatoryInterface="") ::= <<
implements $mandatoryInterface$$if(type.implementedInterfaces)$, $endif$$type.implementedInterfaces; separator=", "$
>>