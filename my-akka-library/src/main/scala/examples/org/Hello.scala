package examples.org

import akka.actor.ActorSystem
import akka.stream.scaladsl._
import scala.collection.immutable
import scala.concurrent.Future

class Hello {
  implicit val system: ActorSystem = ActorSystem("reactive-tweets")

  def hello: Future[immutable.Iterable[String]] = {
    Source(List("1", "2", "3"))
      .map(e => s"this is the element $e")
      .runWith(Sink.collection)
  }
}
