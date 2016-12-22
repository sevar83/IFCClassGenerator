DeepCloneable() ::= <<
$preamble()$

package $package()$;

public interface DeepCloneable extends Cloneable
{
	/**
	 * Method for deep cloning
	 * @return the deep clone
	 */
	public Object clone();
}
>>