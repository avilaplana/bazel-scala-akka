import examples.org.Hello

import scala.collection.immutable
import scala.concurrent.duration._
import scala.concurrent.Await
object Application {
  def main(args: Array[String]): Unit = {
    val a: immutable.Iterable[String] = Await.result(new Hello().hello, Duration.apply(3, "seconds"))
    println(a)
  }
}
