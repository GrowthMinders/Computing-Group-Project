allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Custom build directory configuration
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    // Set custom build directory for each subproject
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)

    // Ensure subprojects depend on the :app project during evaluation
    afterEvaluate {
        if (project.path != ":app") {
            evaluationDependsOn(":app")
        }
    }
}

// Custom clean task to delete the custom build directory
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
    subprojects.forEach { subproject ->
        delete(subproject.layout.buildDirectory)
    }
}