import examples.org.Hello

object Application {
  def main(args: Array[String]): Unit = {
    println((new Hello).hello)
  }
}
