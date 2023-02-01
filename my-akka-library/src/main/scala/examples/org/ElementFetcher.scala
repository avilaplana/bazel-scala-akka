package examples.org

import akka.actor.ActorSystem
import akka.stream.scaladsl._
import scala.collection.immutable
import scala.concurrent.Future

object ElementFetcher {

  def fetchList(implicit system: ActorSystem): Future[immutable.Iterable[String]] =
    Source(List("1", "2", "3"))
      .map(e => s"this is the element $e")
      .runWith(Sink.collection)
}
