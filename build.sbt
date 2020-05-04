lazy val myproject = imgservice  // your existing library

lazy val docs = project       // new documentation project
  .in(file("guide")) // important: it must not be docs/
  .dependsOn(myproject)
  .enablePlugins(MdocPlugin)
