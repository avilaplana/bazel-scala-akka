package examples.org

import org.scalatest._
import flatspec._
import matchers._
import akka.actor.ActorSystem
import org.scalatest.concurrent.ScalaFutures

import java.util.concurrent.TimeUnit
import scala.concurrent.Await
import scala.concurrent.duration.Duration
class ElementFetcherSpec extends AnyFlatSpec with should.Matchers with ScalaFutures with BeforeAndAfterAll {

  implicit val system: ActorSystem = ActorSystem("reactive-tweets")

  override def afterAll() = {
    system.terminate
    Await.ready(system.whenTerminated, Duration(1, TimeUnit.MINUTES))
  }

  "An ElementFetcher" should "fetch the elements" in {
    val elements = ElementFetcher.fetchList(system).futureValue
    elements should contain theSameElementsAs
      List("this is the element 1", "this is the element 2", "this is the element 3")
  }
}
