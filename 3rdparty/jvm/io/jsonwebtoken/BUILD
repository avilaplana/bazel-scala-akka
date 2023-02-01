load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
java_library(
    name = "jjwt_api",
    exports = [
        "//external:jar/io/jsonwebtoken/jjwt_api"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "jjwt_impl",
    exports = [
        "//external:jar/io/jsonwebtoken/jjwt_impl"
    ],
    runtime_deps = [
        ":jjwt_api"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "jjwt_orgjson",
    exports = [
        "//external:jar/io/jsonwebtoken/jjwt_orgjson"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/json:json",
        ":jjwt_api"
    ],
    visibility = [
        "//visibility:public"
    ]
)


