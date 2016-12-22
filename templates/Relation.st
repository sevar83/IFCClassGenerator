Relation() ::= <<
$preamble()$

package $package()$;

/**
 * Relation - a common base for relations with cardinality 1-to-1 and 1-to-N
 * 
 * @author Svetlozar Kostadinov
 *
 * @param <RELATING> type of the relating object
 */
public interface Relation<RELATING extends IfcClass>
{
	public RELATING getRelatingObject();
}
>>