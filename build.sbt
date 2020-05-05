lazy val rootProject = project  // your existing library

lazy val docs = project       // new documentation project
  .in(file("docsrc")) // important: it must not be docs/
  .dependsOn(rootProject)
  .enablePlugins(MdocPlugin)
  .settings(
    mdocIn := file("guide"),
    mdocOut := file("docs")
  )
