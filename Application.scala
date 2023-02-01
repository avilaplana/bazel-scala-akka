import examples.org.ElementFetcher
import java.util.concurrent.TimeUnit
import scala.concurrent.duration._
import scala.concurrent.Await
import akka.actor.ActorSystem

object Application {

  implicit val system: ActorSystem = ActorSystem("reactive-tweets")

  def main(args: Array[String]): Unit = {
    val elements = Await.result(ElementFetcher.fetchList(system), Duration.apply(3, "seconds"))
    println(elements)
    system.terminate
    Await.ready(system.whenTerminated, Duration(1, TimeUnit.MINUTES))
  }

}
