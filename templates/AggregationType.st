AggregationType() ::= <<
$preamble()$

package $package()$;

import $package_reflect()$.Attribute;


public interface AggregationType
{
	/**
	 *  For internal use only
	 *  
	 * @param attributeOwner
	 * @param attribute
	 */
	public void attach(IfcBase attributeOwner, Attribute attribute);
	
	/**
	 *  For internal use only
	 */
	public void detach();
	
	/**
	 *  For internal use only
	 */
	public boolean isAttached();
	
	public Object shallowClone();
}
>>