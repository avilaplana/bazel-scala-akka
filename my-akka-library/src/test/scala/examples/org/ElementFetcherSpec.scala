package examples.org

import org.scalatest._
import flatspec._
import matchers._
import akka.actor.ActorSystem
import org.scalatest.concurrent.ScalaFutures

class ElementFetcherSpec extends AnyFlatSpec with should.Matchers with ScalaFutures {

  implicit val system: ActorSystem = ActorSystem("reactive-tweets")

  "An ElementFetcher" should "fetch the elements" in {
    val elements = ElementFetcher.fetchList(system).futureValue
    elements should contain theSameElementsInOrderAs(
      "this is the element 1",
      "this is the element 2",
      "this is the element 3"
    )
  }
}
