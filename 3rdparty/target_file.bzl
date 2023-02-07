# Do not edit. bazel-deps autogenerates this file from.
_JAVA_LIBRARY_TEMPLATE = """
java_library(
  name = "{name}",
  exports = [
      {exports}
  ],
  runtime_deps = [
    {runtime_deps}
  ],
  visibility = [
      "{visibility}"
  ],
  tags=["maven_coordinates={artifact}"],
)\n"""

_SCALA_IMPORT_TEMPLATE = """
scala_import(
    name = "{name}",
    exports = [
        {exports}
    ],
    jars = [
        {jars}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ],
    tags=["maven_coordinates={artifact}"],
)
"""

_SCALA_LIBRARY_TEMPLATE = """
scala_library(
    name = "{name}",
    exports = [
        {exports}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ],
    tags=["maven_coordinates={artifact}"],
)
"""


def _build_external_workspace_from_opts_impl(ctx):
    build_header = ctx.attr.build_header
    separator = ctx.attr.separator
    target_configs = ctx.attr.target_configs

    result_dict = {}
    for key, cfg in target_configs.items():
      build_file_to_target_name = key.split(":")
      build_file = build_file_to_target_name[0]
      target_name = build_file_to_target_name[1]
      if build_file not in result_dict:
        result_dict[build_file] = []
      result_dict[build_file].append(cfg)

    for key, file_entries in result_dict.items():
      build_file_contents = build_header + '\n\n'
      for build_target in file_entries:
        entry_map = {}
        for entry in build_target:
          elements = entry.split(separator)
          build_entry_key = elements[0]
          if elements[1] == "L":
            entry_map[build_entry_key] = [e for e in elements[2::] if len(e) > 0]
          elif elements[1] == "B":
            entry_map[build_entry_key] = (elements[2] == "true" or elements[2] == "True")
          else:
            entry_map[build_entry_key] = elements[2]

        exports_str = ""
        for e in entry_map.get("exports", []):
          exports_str += "\"" + e + "\",\n"

        jars_str = ""
        for e in entry_map.get("jars", []):
          jars_str += "\"" + e + "\",\n"

        runtime_deps_str = ""
        for e in entry_map.get("runtimeDeps", []):
          runtime_deps_str += "\"" + e + "\",\n"

        name = entry_map["name"].split(":")[1]
        artifact = entry_map["identifier"]
        if entry_map["lang"] == "java":
            build_file_contents += _JAVA_LIBRARY_TEMPLATE.format(name = name, artifact = artifact, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "import":
            build_file_contents += _SCALA_IMPORT_TEMPLATE.format(name = name, artifact = artifact, exports=exports_str, jars=jars_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "library":
            build_file_contents += _SCALA_LIBRARY_TEMPLATE.format(name = name, artifact = artifact, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        else:
            print(entry_map)

      ctx.file(ctx.path(key + "/BUILD"), build_file_contents, False)
    return None

build_external_workspace_from_opts = repository_rule(
    attrs = {
        "target_configs": attr.string_list_dict(mandatory = True),
        "separator": attr.string(mandatory = True),
        "build_header": attr.string(mandatory = True),
    },
    implementation = _build_external_workspace_from_opts_impl
)




def build_header():
 return """load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")"""

def list_target_data_separator():
 return "|||"

def list_target_data():
    return {
"3rdparty/jvm/com/typesafe:config": ["lang||||||java","name||||||//3rdparty/jvm/com/typesafe:config","identifier||||||com.typesafe:config:1.4.0","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/typesafe/config","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/com/typesafe/akka:akka_protobuf_v3_2_13": ["lang||||||java","name||||||//3rdparty/jvm/com/typesafe/akka:akka_protobuf_v3_2_13","identifier||||||com.typesafe.akka:akka-protobuf-v3_2.13:2.6.18","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/typesafe/akka/akka_protobuf_v3_2_13","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/reactivestreams:reactive_streams": ["lang||||||java","name||||||//3rdparty/jvm/org/reactivestreams:reactive_streams","identifier||||||org.reactivestreams:reactive-streams:1.0.3","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/reactivestreams/reactive_streams","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_compatible": ["lang||||||java","name||||||//3rdparty/jvm/org/scalatest:scalatest_compatible","identifier||||||org.scalatest:scalatest-compatible:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/scalatest/scalatest_compatible","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scala_lang:scala_compiler": ["lang||||||scala/unmangled:2.13.6","name||||||//3rdparty/jvm/org/scala_lang:scala_compiler","identifier||||||","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||@io_bazel_rules_scala_scala_compiler//:io_bazel_rules_scala_scala_compiler","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scala_lang:scala_library": ["lang||||||scala/unmangled:2.13.6","name||||||//3rdparty/jvm/org/scala_lang:scala_library","identifier||||||org.scala-lang:scala-library:2.13.7","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||@io_bazel_rules_scala_scala_library//:io_bazel_rules_scala_scala_library","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scala_lang:scala_reflect": ["lang||||||scala/unmangled:2.13.6","name||||||//3rdparty/jvm/org/scala_lang:scala_reflect","identifier||||||org.scala-lang:scala-reflect:2.13.4","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||@io_bazel_rules_scala_scala_reflect//:io_bazel_rules_scala_scala_reflect","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/com/typesafe:ssl_config_core": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/com/typesafe:ssl_config_core","identifier||||||com.typesafe:ssl-config-core_2.13:0.4.2","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/com/typesafe/ssl_config_core_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators|||//3rdparty/jvm/com/typesafe:config","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/com/typesafe/akka:akka_actor": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/com/typesafe/akka:akka_actor","identifier||||||com.typesafe.akka:akka-actor_2.13:2.6.18","visibility||||||//visibility:public","kind||||||import","deps|||L|||","jars|||L|||//external:jar/com/typesafe/akka/akka_actor_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/com/typesafe:config|||//3rdparty/jvm/org/scala_lang/modules:scala_java8_compat","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/com/typesafe/akka:akka_stream": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/com/typesafe/akka:akka_stream","identifier||||||com.typesafe.akka:akka-stream_2.13:2.6.18","visibility||||||//visibility:public","kind||||||import","deps|||L|||","jars|||L|||//external:jar/com/typesafe/akka/akka_stream_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/reactivestreams:reactive_streams|||//3rdparty/jvm/com/typesafe/akka:akka_actor|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/com/typesafe:ssl_config_core|||//3rdparty/jvm/com/typesafe/akka:akka_protobuf_v3_2_13","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scala_lang/modules:scala_java8_compat": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scala_lang/modules:scala_java8_compat","identifier||||||org.scala-lang.modules:scala-java8-compat_2.13:1.0.0","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scala_lang/modules/scala_java8_compat_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators","identifier||||||org.scala-lang.modules:scala-parser-combinators_2.13:1.1.2","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||@io_bazel_rules_scala_scala_parser_combinators//:io_bazel_rules_scala_scala_parser_combinators","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scala_lang/modules:scala_xml": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scala_lang/modules:scala_xml","identifier||||||org.scala-lang.modules:scala-xml_2.13:1.3.0","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||@io_bazel_rules_scala_scala_xml//:io_bazel_rules_scala_scala_xml","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalactic:scalactic": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalactic:scalactic","identifier||||||org.scalactic:scalactic_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalactic/scalactic_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest","identifier||||||org.scalatest:scalatest_2.13:3.2.9","visibility||||||//visibility:public","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scalatest:scalatest_shouldmatchers|||//3rdparty/jvm/org/scalatest:scalatest_freespec|||//3rdparty/jvm/org/scalatest:scalatest_funsuite|||//3rdparty/jvm/org/scala_lang:scala_reflect|||//3rdparty/jvm/org/scalatest:scalatest_refspec|||//3rdparty/jvm/org/scalatest:scalatest_mustmatchers|||//3rdparty/jvm/org/scalatest:scalatest_matchers_core|||//3rdparty/jvm/org/scalatest:scalatest_funspec|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_flatspec|||//3rdparty/jvm/org/scalatest:scalatest_propspec|||//3rdparty/jvm/org/scalatest:scalatest_featurespec|||//3rdparty/jvm/org/scalatest:scalatest_wordspec|||//3rdparty/jvm/org/scalatest:scalatest_diagrams","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_core": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_core","identifier||||||org.scalatest:scalatest-core_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_core_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_reflect|||//3rdparty/jvm/org/scalatest:scalatest_compatible|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalactic:scalactic|||//3rdparty/jvm/org/scala_lang/modules:scala_xml","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_diagrams": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_diagrams","identifier||||||org.scalatest:scalatest-diagrams_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_diagrams_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_featurespec": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_featurespec","identifier||||||org.scalatest:scalatest-featurespec_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_featurespec_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_flatspec": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_flatspec","identifier||||||org.scalatest:scalatest-flatspec_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_flatspec_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_freespec": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_freespec","identifier||||||org.scalatest:scalatest-freespec_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_freespec_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_funspec": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_funspec","identifier||||||org.scalatest:scalatest-funspec_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_funspec_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_funsuite": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_funsuite","identifier||||||org.scalatest:scalatest-funsuite_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_funsuite_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_matchers_core": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_matchers_core","identifier||||||org.scalatest:scalatest-matchers-core_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_matchers_core_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect|||//3rdparty/jvm/org/scala_lang:scala_library","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_mustmatchers": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_mustmatchers","identifier||||||org.scalatest:scalatest-mustmatchers_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_mustmatchers_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_matchers_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_propspec": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_propspec","identifier||||||org.scalatest:scalatest-propspec_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_propspec_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_refspec": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_refspec","identifier||||||org.scalatest:scalatest-refspec_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_refspec_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_shouldmatchers": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_shouldmatchers","identifier||||||org.scalatest:scalatest-shouldmatchers_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_shouldmatchers_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_matchers_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/scalatest:scalatest_wordspec": ["lang||||||scala:2.13.6","name||||||//3rdparty/jvm/org/scalatest:scalatest_wordspec","identifier||||||org.scalatest:scalatest-wordspec_2.13:3.2.9","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||import","deps|||L|||","jars|||L|||//external:jar/org/scalatest/scalatest_wordspec_2_13","sources|||L|||","exports|||L|||","runtimeDeps|||L|||//3rdparty/jvm/org/scala_lang:scala_library|||//3rdparty/jvm/org/scalatest:scalatest_core|||//3rdparty/jvm/org/scala_lang:scala_reflect","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"]
 }


def build_external_workspace(name):
  return build_external_workspace_from_opts(name = name, target_configs = list_target_data(), separator = list_target_data_separator(), build_header = build_header())

