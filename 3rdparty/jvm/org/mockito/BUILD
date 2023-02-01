load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
java_library(
    name = "mockito_core",
    exports = [
        "//external:jar/org/mockito/mockito_core"
    ],
    runtime_deps = [
        "//3rdparty/jvm/net/bytebuddy:byte_buddy",
        "//3rdparty/jvm/net/bytebuddy:byte_buddy_agent",
        "//3rdparty/jvm/org/objenesis:objenesis"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



scala_import(
    name = "mockito_scala",
    jars = [
        "//external:jar/org/mockito/mockito_scala_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/scalactic:scalactic",
        "//3rdparty/jvm/ru/vyarus:generics_resolver",
        ":mockito_core"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



scala_import(
    name = "mockito_scala_scalatest",
    jars = [
        "//external:jar/org/mockito/mockito_scala_scalatest_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        ":mockito_scala"
    ],
    visibility = [
        "//visibility:public"
    ]
)


