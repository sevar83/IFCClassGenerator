ENTITYClass(entity) ::= <<
$preamble()$

package $package()$;

import $package_reflect()$.*;


@SuppressWarnings({"unused", "unchecked"})
public $class(entity)$ $extends(entity)$$implements_(entity, "IfcClass")$
{
	// Explicit Attribute descriptors
	$entity.explicitAttributes:explicitAttributeDescription(); separator="\n"$
		
	// Inverse Attribute descriptors
	$entity.inverseAttributes:inverseAttributeDescription(); separator="\n"$
	
	// Explicit Attribute fields
	$entity.explicitAttributes:explicitAttributeDeclaration(); separator="\n"$
	
	// Inverse Attribute fields
	$entity.inverseAttributes:inverseAttributeDeclaration(); separator="\n"$

	public $entity.id$($entity.allExplicitAttributes:argDecl(); separator=", "$)
	{
		super($entity.explicitAttributesOfSuper: {a | $privateAttributeName(a.id)$} ; separator=", "$);
		
		classInitializeAttributes($entity.id$.class$if(entity.explicitAttributes)$, $endif$$entity.explicitAttributes: {a | $privateAttributeName(a.id)$} ; separator=", "$);
	}

	$entity.explicitAttributes:explicitAttributeAccessors(); separator="\n"$
	
	$entity.inverseAttributes:inverseAttributeGetter(); separator="\n"$
	
	@Override	
	public $entity.id$ clone()
	{
		$entity.id$ clone = ($entity.id$) super.clone();
		
		classCloneAttributes($entity.id$.class, clone);
		
		return clone;
	}
	
	@Override	
	public $entity.id$ shallowClone()
	{
		$entity.id$ clone = ($entity.id$) super.clone();

		classCloneAttributes($entity.id$.class, clone);
		
		return clone;
	}
}
>>