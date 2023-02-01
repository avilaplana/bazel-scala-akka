load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
java_library(
    name = "google_cloud_core",
    exports = [
        "//external:jar/com/google/cloud/google_cloud_core"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



java_library(
    name = "google_cloud_core_grpc",
    exports = [
        "//external:jar/com/google/cloud/google_cloud_core_grpc"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



java_library(
    name = "google_cloud_firestore",
    exports = [
        "//external:jar/com/google/cloud/google_cloud_firestore"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/android:annotations",
        "//3rdparty/jvm/com/google/api/grpc:proto_google_cloud_firestore_v1",
        "//3rdparty/jvm/com/google/api/grpc:proto_google_common_protos",
        "//3rdparty/jvm/com/google/api/grpc:proto_google_iam_v1",
        "//3rdparty/jvm/com/google/api:api_common",
        "//3rdparty/jvm/com/google/api:gax",
        "//3rdparty/jvm/com/google/api:gax_grpc",
        "//3rdparty/jvm/com/google/auth:google_auth_library_credentials",
        "//3rdparty/jvm/com/google/auth:google_auth_library_oauth2_http",
        "//3rdparty/jvm/com/google/auto/value:auto_value_annotations",
        "//3rdparty/jvm/com/google/code/findbugs:jsr305",
        "//3rdparty/jvm/com/google/code/gson:gson",
        "//3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//3rdparty/jvm/com/google/guava:failureaccess",
        "//3rdparty/jvm/com/google/guava:guava",
        "//3rdparty/jvm/com/google/guava:listenablefuture",
        "//3rdparty/jvm/com/google/http_client:google_http_client",
        "//3rdparty/jvm/com/google/http_client:google_http_client_gson",
        "//3rdparty/jvm/com/google/j2objc:j2objc_annotations",
        "//3rdparty/jvm/com/google/protobuf:protobuf_java",
        "//3rdparty/jvm/com/google/protobuf:protobuf_java_util",
        "//3rdparty/jvm/com/google/re2j:re2j",
        "//3rdparty/jvm/commons_codec:commons_codec",
        "//3rdparty/jvm/commons_logging:commons_logging",
        "//3rdparty/jvm/io/grpc:grpc_alts",
        "//3rdparty/jvm/io/grpc:grpc_api",
        "//3rdparty/jvm/io/grpc:grpc_auth",
        "//3rdparty/jvm/io/grpc:grpc_context",
        "//3rdparty/jvm/io/grpc:grpc_core",
        "//3rdparty/jvm/io/grpc:grpc_grpclb",
        "//3rdparty/jvm/io/grpc:grpc_netty_shaded",
        "//3rdparty/jvm/io/grpc:grpc_protobuf",
        "//3rdparty/jvm/io/grpc:grpc_protobuf_lite",
        "//3rdparty/jvm/io/grpc:grpc_services",
        "//3rdparty/jvm/io/grpc:grpc_stub",
        "//3rdparty/jvm/io/grpc:grpc_xds",
        "//3rdparty/jvm/io/opencensus:opencensus_api",
        "//3rdparty/jvm/io/opencensus:opencensus_contrib_grpc_util",
        "//3rdparty/jvm/io/opencensus:opencensus_contrib_http_util",
        "//3rdparty/jvm/io/opencensus:opencensus_proto",
        "//3rdparty/jvm/io/perfmark:perfmark_api",
        "//3rdparty/jvm/javax/annotation:javax_annotation_api",
        "//3rdparty/jvm/org/apache/httpcomponents:httpclient",
        "//3rdparty/jvm/org/apache/httpcomponents:httpcore",
        "//3rdparty/jvm/org/bouncycastle:bcpkix_jdk15on",
        "//3rdparty/jvm/org/bouncycastle:bcprov_jdk15on",
        "//3rdparty/jvm/org/checkerframework:checker_qual",
        "//3rdparty/jvm/org/codehaus/mojo:animal_sniffer_annotations",
        "//3rdparty/jvm/org/conscrypt:conscrypt_openjdk_uber",
        "//3rdparty/jvm/org/threeten:threetenbp",
        ":google_cloud_core",
        ":google_cloud_core_grpc",
        ":proto_google_cloud_firestore_bundle_v1"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "proto_google_cloud_firestore_bundle_v1",
    exports = [
        "//external:jar/com/google/cloud/proto_google_cloud_firestore_bundle_v1"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/api/grpc:proto_google_common_protos",
        "//3rdparty/jvm/com/google/api:api_common",
        "//3rdparty/jvm/com/google/auto/value:auto_value_annotations",
        "//3rdparty/jvm/com/google/code/findbugs:jsr305",
        "//3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//3rdparty/jvm/com/google/guava:failureaccess",
        "//3rdparty/jvm/com/google/guava:guava",
        "//3rdparty/jvm/com/google/guava:listenablefuture",
        "//3rdparty/jvm/com/google/j2objc:j2objc_annotations",
        "//3rdparty/jvm/javax/annotation:javax_annotation_api",
        "//3rdparty/jvm/org/checkerframework:checker_qual"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)


