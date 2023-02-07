# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output = ctx.path("jar/%s" % jar_name),
        url = ctx.attr.urls,
        sha256 = ctx.attr.sha256,
        executable = False
    )
    src_name = "%s-sources.jar" % ctx.name
    srcjar_attr = ""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output = ctx.path("jar/%s" % src_name),
            url = ctx.attr.src_urls,
            sha256 = ctx.attr.src_sha256,
            executable = False
        )
        srcjar_attr = '\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public'],
    tags = ['maven_coordinates={artifact}'],
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "com.typesafe.akka:akka-actor_2.13:2.6.18", "lang": "scala", "sha1": "c5f8fe20cef5c2c78b4e4452fc221594fdefb678", "sha256": "e62515453b841a82062ea7660471afe055981cc16491ce7f74561522d8275de5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor_2.13/2.6.18/akka-actor_2.13-2.6.18.jar", "source": {"sha1": "6165b5edf23f85305d420a38224aed0fccb3c23d", "sha256": "996e7c9cda36c2189f0146b404066e806a946e7e6f68de11cf1cce775b2db19e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor_2.13/2.6.18/akka-actor_2.13-2.6.18-sources.jar"} , "name": "com_typesafe_akka_akka_actor_2_13", "actual": "@com_typesafe_akka_akka_actor_2_13//jar:file", "bind": "jar/com/typesafe/akka/akka_actor_2_13"},
    {"artifact": "com.typesafe.akka:akka-protobuf-v3_2.13:2.6.18", "lang": "java", "sha1": "ed221bf728e818b7f336bb6cdb37b68cc1509e83", "sha256": "7084e545c6ef2cdee26a78000962d5581288878a632c3e3e23e56c48d21dc510", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-protobuf-v3_2.13/2.6.18/akka-protobuf-v3_2.13-2.6.18.jar", "source": {"sha1": "ef1036e00c5f34f7d66b433751eff6ebd0420f43", "sha256": "dd6d66406ea1db99da99abd6e051e6f6074b82337e64f9ee3f7294c17e6ad418", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-protobuf-v3_2.13/2.6.18/akka-protobuf-v3_2.13-2.6.18-sources.jar"} , "name": "com_typesafe_akka_akka_protobuf_v3_2_13", "actual": "@com_typesafe_akka_akka_protobuf_v3_2_13//jar", "bind": "jar/com/typesafe/akka/akka_protobuf_v3_2_13"},
    {"artifact": "com.typesafe.akka:akka-stream_2.13:2.6.18", "lang": "scala", "sha1": "ffc3c785599bc997397936dc1d922cdd022d78d9", "sha256": "de1355d6da0034c280ef3eb364dd8b624194fcbbd1157c829345fa55d33c24d2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-stream_2.13/2.6.18/akka-stream_2.13-2.6.18.jar", "source": {"sha1": "63bdcc918e1b3c5c8e69c6d000323e0c8343ae79", "sha256": "21a271b6608372e3e4657375eb7d0453cca13cff2cc3043d69fb2d36b4fdae3d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-stream_2.13/2.6.18/akka-stream_2.13-2.6.18-sources.jar"} , "name": "com_typesafe_akka_akka_stream_2_13", "actual": "@com_typesafe_akka_akka_stream_2_13//jar:file", "bind": "jar/com/typesafe/akka/akka_stream_2_13"},
    {"artifact": "com.typesafe:config:1.4.0", "lang": "java", "sha1": "a8b341fe81552834edc231193afd6f56a96f0eff", "sha256": "aadbfd5a524551beef10d3f891d305b83bb27d54703d9a4de7aca2a12d9847e2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/config/1.4.0/config-1.4.0.jar", "source": {"sha1": "e748b8348e1910b0935bf662e21e748290229e7f", "sha256": "ffaf8892dc8c61605bd7319c6cdcea022b6c9c28b62776915a809e8de93d8a6e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/config/1.4.0/config-1.4.0-sources.jar"} , "name": "com_typesafe_config", "actual": "@com_typesafe_config//jar", "bind": "jar/com/typesafe/config"},
    {"artifact": "com.typesafe:ssl-config-core_2.13:0.4.2", "lang": "scala", "sha1": "93eaf36919de5cfa68f39874c1829faba2a66e4b", "sha256": "1636d8a57653afe20afd7f7a1449c3bab7d2a94b91bafaa44d7dfeb235740767", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/ssl-config-core_2.13/0.4.2/ssl-config-core_2.13-0.4.2.jar", "source": {"sha1": "1ab7f768512e0100d47aee9252203efd0cffd6ee", "sha256": "22401783057d7f6953b77eefe65c4a5ed01d7be8489dff6ec18fc27ecfd38d5d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/ssl-config-core_2.13/0.4.2/ssl-config-core_2.13-0.4.2-sources.jar"} , "name": "com_typesafe_ssl_config_core_2_13", "actual": "@com_typesafe_ssl_config_core_2_13//jar:file", "bind": "jar/com/typesafe/ssl_config_core_2_13"},
    {"artifact": "org.reactivestreams:reactive-streams:1.0.3", "lang": "java", "sha1": "d9fb7a7926ffa635b3dcaa5049fb2bfa25b3e7d0", "sha256": "1dee0481072d19c929b623e155e14d2f6085dc011529a0a0dbefc84cf571d865", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/reactivestreams/reactive-streams/1.0.3/reactive-streams-1.0.3.jar", "source": {"sha1": "e6ffdff8c438d959376c91d94b319457354a84c5", "sha256": "d5b4070a22c9b1ca5b9b5aa668466bcca391dbe5d5fe8311c300765c1621feba", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/reactivestreams/reactive-streams/1.0.3/reactive-streams-1.0.3-sources.jar"} , "name": "org_reactivestreams_reactive_streams", "actual": "@org_reactivestreams_reactive_streams//jar", "bind": "jar/org/reactivestreams/reactive_streams"},
    {"artifact": "org.scala-lang.modules:scala-java8-compat_2.13:1.0.0", "lang": "scala", "sha1": "8ffac68615b438933fe27506e755d790a68b8bab", "sha256": "879b3e718453c8b934ff5e8225107a24701bde392f96daf6135f94f9e161dbc5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-java8-compat_2.13/1.0.0/scala-java8-compat_2.13-1.0.0.jar", "source": {"sha1": "95cc5797c984881104e3858b785aa8a6de11f59e", "sha256": "db7bbbf2fbaeefd10898492ae4ef6e400a8b873974a2d44cfc0a460a279680c4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-java8-compat_2.13/1.0.0/scala-java8-compat_2.13-1.0.0-sources.jar"} , "name": "org_scala_lang_modules_scala_java8_compat_2_13", "actual": "@org_scala_lang_modules_scala_java8_compat_2_13//jar:file", "bind": "jar/org/scala_lang/modules/scala_java8_compat_2_13"},
    {"artifact": "org.scalactic:scalactic_2.13:3.2.9", "lang": "scala", "sha1": "2bf4d2f3176b7ac9a283c1153b51c792cb373814", "sha256": "dcb853409202fee6f8e7216b363aab5b68edc07a51d27b61d5bf3fdf4418c9da", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.13/3.2.9/scalactic_2.13-3.2.9.jar", "source": {"sha1": "c089b3d0d8436423fd7a22ccf51de2dd448c8914", "sha256": "c721a35914b328e30c2773de52b2e16a5565c136b4cec1692e6668e5c75d98b7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.13/3.2.9/scalactic_2.13-3.2.9-sources.jar"} , "name": "org_scalactic_scalactic_2_13", "actual": "@org_scalactic_scalactic_2_13//jar:file", "bind": "jar/org/scalactic/scalactic_2_13"},
    {"artifact": "org.scalatest:scalatest-compatible:3.2.9", "lang": "java", "sha1": "c7378594161a6a559bd5992f9b961eed9277d7ff", "sha256": "7e5f1193af2fd88c432c4b80ce3641e4b1d062f421d8a0fcc43af9a19bb7c2eb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-compatible/3.2.9/scalatest-compatible-3.2.9.jar", "source": {"sha1": "7d3a5de68aba60b4c0476ea318d0623778ad2297", "sha256": "2d2d8645e812f6acae111ea36f6f53a970692e8927a2846886a024286538217d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-compatible/3.2.9/scalatest-compatible-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_compatible", "actual": "@org_scalatest_scalatest_compatible//jar", "bind": "jar/org/scalatest/scalatest_compatible"},
    {"artifact": "org.scalatest:scalatest-core_2.13:3.2.9", "lang": "scala", "sha1": "350a403eda29bdccf891accba57b6f21ec03740e", "sha256": "b238f0e42edd471c8d066d25fa925d4c0cfae33b8db1ea79d14ff42047263e5d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-core_2.13/3.2.9/scalatest-core_2.13-3.2.9.jar", "source": {"sha1": "bf64e4bb2afea8bf4be96eb785a4f8179c661c93", "sha256": "c1c1e7e939a43a59f1919c87b7574e6afb6911bce9ee54dc3a19e8c8a5074234", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-core_2.13/3.2.9/scalatest-core_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_core_2_13", "actual": "@org_scalatest_scalatest_core_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_core_2_13"},
    {"artifact": "org.scalatest:scalatest-diagrams_2.13:3.2.9", "lang": "scala", "sha1": "d2662c109835b6075460ee6ad5fd72278455492a", "sha256": "803d4f2ce03b581ed5435a097a20882809dfe48b87ed232f13a98e718ceb731d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-diagrams_2.13/3.2.9/scalatest-diagrams_2.13-3.2.9.jar", "source": {"sha1": "99c3dad4d3e1b486c2fcad5210bfb0c2dff24deb", "sha256": "b6c5c8c1d658385a5508f495ad58bebae10623c5d04eb3c12ce08b80de9290e1", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-diagrams_2.13/3.2.9/scalatest-diagrams_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_diagrams_2_13", "actual": "@org_scalatest_scalatest_diagrams_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_diagrams_2_13"},
    {"artifact": "org.scalatest:scalatest-featurespec_2.13:3.2.9", "lang": "scala", "sha1": "c0e096afee8c2ad40abc014bfd9860534c5cf117", "sha256": "f8ec83a39554c1e44f6ef5e13d9b87bf8257067b0dad8ee6012fec36e318036d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-featurespec_2.13/3.2.9/scalatest-featurespec_2.13-3.2.9.jar", "source": {"sha1": "c8a8f306f94fadcf232c5260d10b83402513881a", "sha256": "1099311e9e617be58951e474e8bec1580cd027996c3330a5d236a7d5b527f7ef", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-featurespec_2.13/3.2.9/scalatest-featurespec_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_featurespec_2_13", "actual": "@org_scalatest_scalatest_featurespec_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_featurespec_2_13"},
    {"artifact": "org.scalatest:scalatest-flatspec_2.13:3.2.9", "lang": "scala", "sha1": "1d79ccdde578c7d90ea4938a3b7bafaac22130e7", "sha256": "6a1bc2f522105b4eda53c225f3d5cbdabbf3e9375136dde57a5b43846369f75a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-flatspec_2.13/3.2.9/scalatest-flatspec_2.13-3.2.9.jar", "source": {"sha1": "dbeee99d8317e2b1d30ed592c727561865d0d5a6", "sha256": "81ab486a9418c0584b21d23ebe356c3dc5304728303254cd3ce71dc46c9a83f4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-flatspec_2.13/3.2.9/scalatest-flatspec_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_flatspec_2_13", "actual": "@org_scalatest_scalatest_flatspec_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_flatspec_2_13"},
    {"artifact": "org.scalatest:scalatest-freespec_2.13:3.2.9", "lang": "scala", "sha1": "558c6e981f3ad452e765f946b768c10e94a1d2a6", "sha256": "db3467bb0b34c1ca8d9830cf40179e2900ac01d5119f7a1b6bdcef30adb62214", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-freespec_2.13/3.2.9/scalatest-freespec_2.13-3.2.9.jar", "source": {"sha1": "a82a9fcbd6449ca9d327b0b3af389c534e77ee8c", "sha256": "607f5aae82a6a342b14ba788188e6a0fbccea126e104370630e5513b976ebbf0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-freespec_2.13/3.2.9/scalatest-freespec_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_freespec_2_13", "actual": "@org_scalatest_scalatest_freespec_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_freespec_2_13"},
    {"artifact": "org.scalatest:scalatest-funspec_2.13:3.2.9", "lang": "scala", "sha1": "0ca67377903be97c25d306d264ecac9321acfb92", "sha256": "821d13ced0bf96d1470538cbcca3109694148f2637961e5c502639e16ab7eee9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-funspec_2.13/3.2.9/scalatest-funspec_2.13-3.2.9.jar", "source": {"sha1": "b6d14a2524fb955c7afd43ef6c8d8c10ef89fbbc", "sha256": "04414a6d5ca438f72fcf35ac91ced9c4e382a1a090a77146c7ff6f4902cd7f3a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-funspec_2.13/3.2.9/scalatest-funspec_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_funspec_2_13", "actual": "@org_scalatest_scalatest_funspec_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_funspec_2_13"},
    {"artifact": "org.scalatest:scalatest-funsuite_2.13:3.2.9", "lang": "scala", "sha1": "37e0d60cee161e28a0b70fe761f8fcc20b28a6e5", "sha256": "d6455470fabc9f3a5a7a50770f6e1a4f4d0114122885637f3df684e5bb501f9d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-funsuite_2.13/3.2.9/scalatest-funsuite_2.13-3.2.9.jar", "source": {"sha1": "393066c0a3f3d82ca913c6040d9a90c80f14bcbc", "sha256": "8faa4e26f7f86e518fa1743e0ea1f87c298525408b9f02b0e8f4fd8e36f02711", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-funsuite_2.13/3.2.9/scalatest-funsuite_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_funsuite_2_13", "actual": "@org_scalatest_scalatest_funsuite_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_funsuite_2_13"},
    {"artifact": "org.scalatest:scalatest-matchers-core_2.13:3.2.9", "lang": "scala", "sha1": "4457e954c41fa7b44278c36d3510611c624996a9", "sha256": "b86ed6f0986d005f4d54af5effdb73a18fe5741533f6663631d17a0731b9616f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-matchers-core_2.13/3.2.9/scalatest-matchers-core_2.13-3.2.9.jar", "source": {"sha1": "86f9aae3c551a7129eb094796367705e0cdcde0f", "sha256": "3f6eafe9c3ed756ac5b25641c6dfa354f49a88a845b73830490598a6607e36fc", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-matchers-core_2.13/3.2.9/scalatest-matchers-core_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_matchers_core_2_13", "actual": "@org_scalatest_scalatest_matchers_core_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_matchers_core_2_13"},
    {"artifact": "org.scalatest:scalatest-mustmatchers_2.13:3.2.9", "lang": "scala", "sha1": "a3270383806bf8ad8094d737b3c074c0201e25c9", "sha256": "e170d4ff75f0e96458b7ec072accd40ff585f9e444b5831ba84287ff2da70f2c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-mustmatchers_2.13/3.2.9/scalatest-mustmatchers_2.13-3.2.9.jar", "source": {"sha1": "17084a076698bc91ab48a291df72e091a9634947", "sha256": "7c34f2459f03636999a1b1d1c6c76054901b43ce4e94d79e2c56b3f965476b35", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-mustmatchers_2.13/3.2.9/scalatest-mustmatchers_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_mustmatchers_2_13", "actual": "@org_scalatest_scalatest_mustmatchers_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_mustmatchers_2_13"},
    {"artifact": "org.scalatest:scalatest-propspec_2.13:3.2.9", "lang": "scala", "sha1": "eafaf4b0058fdd81e2adca0b4bb37e1bffa8a0a3", "sha256": "f08355a14c5afece8130016a9f8e5bbc4196f4b612fefefb2acf223fb9f92607", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-propspec_2.13/3.2.9/scalatest-propspec_2.13-3.2.9.jar", "source": {"sha1": "ba15f6ad236d4b8bc5641bb516f19348de3309d1", "sha256": "968b121c006575a83590edfc6909c992ee5b22ec99230ed53b53c21d06958826", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-propspec_2.13/3.2.9/scalatest-propspec_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_propspec_2_13", "actual": "@org_scalatest_scalatest_propspec_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_propspec_2_13"},
    {"artifact": "org.scalatest:scalatest-refspec_2.13:3.2.9", "lang": "scala", "sha1": "cef5a84cb7848c271f88dcb6c7f288739bf26fb9", "sha256": "edd37859e64c4f18ef266a28603ac7d85649f3f3cc26c14eb093d60199eaec03", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-refspec_2.13/3.2.9/scalatest-refspec_2.13-3.2.9.jar", "source": {"sha1": "10fbe649b9f47182c1bc8151529447e2b1a44cd1", "sha256": "1959d3a0f9f9b117c7b09f9a69f589e3e904363912e7017c3a6e3e328a81c0f1", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-refspec_2.13/3.2.9/scalatest-refspec_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_refspec_2_13", "actual": "@org_scalatest_scalatest_refspec_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_refspec_2_13"},
    {"artifact": "org.scalatest:scalatest-shouldmatchers_2.13:3.2.9", "lang": "scala", "sha1": "15f538217a0930508464cb54e29e23ce0dbcf3de", "sha256": "39a4eefa409fed5a32eff3647aa4f80628202d966e3cb6a9f01e88dcfae75e4c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-shouldmatchers_2.13/3.2.9/scalatest-shouldmatchers_2.13-3.2.9.jar", "source": {"sha1": "5dc914c888d41eabf54ed4cd21bebc4889a49d3e", "sha256": "0bf2b1b0143a9668bac6f2eedf3637bf223a4937c53818d193232f7d9d2f5ff2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-shouldmatchers_2.13/3.2.9/scalatest-shouldmatchers_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_shouldmatchers_2_13", "actual": "@org_scalatest_scalatest_shouldmatchers_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_shouldmatchers_2_13"},
    {"artifact": "org.scalatest:scalatest-wordspec_2.13:3.2.9", "lang": "scala", "sha1": "9f9ef553a9a4de7cb4c1d172ad850d7a63553bc7", "sha256": "c5d5424bc43f02df9720bd83c57daa982af02ad7ae468875956ebe183f836277", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-wordspec_2.13/3.2.9/scalatest-wordspec_2.13-3.2.9.jar", "source": {"sha1": "a79ec1d2079f8d194288e9f5adb4c6c973d6f2f3", "sha256": "8a6f23594cf387e6c30f188ea308752e6da469e0477b7a11423d9f9999f2b66f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest-wordspec_2.13/3.2.9/scalatest-wordspec_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_wordspec_2_13", "actual": "@org_scalatest_scalatest_wordspec_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_wordspec_2_13"},
    {"artifact": "org.scalatest:scalatest_2.13:3.2.9", "lang": "scala", "sha1": "e58e048b7f14929f1033f33ae9cbbd9e6d0c3782", "sha256": "c5d283a5ec028bf06f83d70e2b88d70a149dd574d19e79e8389b49483914b08b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.13/3.2.9/scalatest_2.13-3.2.9.jar", "source": {"sha1": "9fbd87556a38dee844956bac527cade00488f6ce", "sha256": "825a948573fc0cd462a92b7efab0fd3f740e00947158a9afce53458cbb285611", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.13/3.2.9/scalatest_2.13-3.2.9-sources.jar"} , "name": "org_scalatest_scalatest_2_13", "actual": "@org_scalatest_scalatest_2_13//jar:file", "bind": "jar/org/scalatest/scalatest_2_13"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
