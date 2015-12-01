/**
 * use as
 *  sbt console
 *  import ListUtils._
 */
import scala.util.Random

object ListUtils {

    val r = new Random()

    def randIntList(len: Int, min: Int = 0, max: Int = 100): List[Int] = {
        require(max > min)
        (for (
            i <- 0 until len
        ) yield r.nextInt(max - min + 1) + min).toList
    }


    val list1 = randIntList(10)
    val list2 = randIntList(10)

    val uniqueList1 = randIntList(10).distinct
    val uniqueList2 = randIntList(10).distinct
}
