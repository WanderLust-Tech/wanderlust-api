INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'What is Chromium?', N'# Chromium Knowledge Base Overview (v134+)

Welcome to the **Wanderlust Knowledge Base**! This comprehensive resource is designed to help you navigate, understand, and contribute to modern Chromium''s sophisticated codebase and the **custom-browser project** built upon it.

---

## 1. What Is Modern Chromium? (v134+)

- **Definition**  
  Chromium is the cutting-edge open-source browser engine powering Google Chrome, Microsoft Edge, Opera, Brave, and our **custom-browser project**. As of v134+, it represents one of the most sophisticated software architectures ever built.

- **Modern Goals & Achievements**  
  – **Performance Excellence**: 60+ FPS rendering, sub-100ms navigation, Core Web Vitals optimization  
  – **Advanced Security**: Site isolation, Control Flow Integrity (CFI), Privacy Sandbox integration  
  – **Cross-Platform Mastery**: Windows, macOS, Linux, Chrome OS, Android, iOS with platform-specific optimizations  
  – **Web Standards Leadership**: WebGPU, WebAssembly, Progressive Web Apps, and emerging APIs  

- **v134+ Evolution & Community**  
  – **Origin**: Started by Google in 2008, now a massive collaborative effort  
  – **Modern Scale**: 25+ million lines of code, 1000+ daily commits, global contributor network  
  – **Contribution Ecosystem**: Chromium Bug Tracker, Gerrit code review, specialized mailing lists  
  – **Innovation Hub**: Driving web platform evolution and browser technology advancement  

---

## 2. Why Explore Modern Chromium Source? (v134+)

- **Advanced Learning Opportunities**  
  – **Modern C++20/23 Practices**: Template metaprogramming, memory safety, performance optimization  
  – **Service-Oriented Architecture**: Microservice design with Mojo IPC, process coordination  
  – **Graphics & Rendering**: Viz compositor, GPU acceleration, advanced rendering pipelines  
  – **Security Engineering**: Multi-layered security, sandboxing, exploit mitigation techniques  

- **Professional Development**  
  – **Performance Engineering**: Memory optimization, threading, real-time systems  
  – **Cross-Platform Development**: Platform abstraction, native integration, responsive design  
  – **Large-Scale Software Architecture**: Managing complexity, modularity, maintainability  
  – **Web Technology Innovation**: Implementing cutting-edge web standards and APIs  

- **Custom Browser Development**  
  – **Feature Implementation**: Adding custom functionality to browser components  
  – **Performance Tuning**: Optimizing for specific use cases and hardware configurations  
  – **Security Enhancements**: Implementing additional security layers and privacy features  
  – **Integration Possibilities**: Connecting with external services, APIs, and platforms  

---

## 3. Modern Multi-Process Architecture (v134+)

Chromium''s sophisticated architecture has evolved significantly:

### Core Processes
- **Browser Process**: Central coordinator with enhanced UI management and service orchestration
- **Renderer Processes**: Site-isolated content rendering with strict security boundaries
- **GPU Process**: Unified Viz compositor with Out-of-Process Rasterization (OOP-R)
- **Network Service**: Dedicated network process with HTTP/3 and QUIC support

### Modern Service Ecosystem
- **Audio Service**: Isolated audio processing and hardware acceleration
- **Storage Service**: Centralized data management with enhanced privacy controls
- **Device Service**: Secure hardware access with permission management
- **ML Service**: On-device machine learning with TensorFlow Lite integration
- **Utility Processes**: Sandboxed processing for various specialized tasks

### Advanced Features (v134+)
- **Site Isolation**: Per-origin process boundaries for enhanced security
- **Mojo IPC**: Type-safe inter-process communication with capability-based security
- **Service Manager**: Intelligent service coordination and dependency management
- **Enhanced Sandboxing**: Platform-specific security with CFI and memory protection

_(Explore detailed sections: [Process Model](../architecture/process-model.md), [Render Pipeline](../architecture/render-pipeline.md), [IPC Internals](../architecture/ipc-internals.md))_

---

## 4. Custom-Browser Project Structure

Our enhanced directory layout integrates custom modifications with upstream Chromium:

```text
custom-browser/
├── .gclient                 # Chromium source synchronization
├── package.json             # Project configuration and dependencies
├── requirements.txt         # Python development tools
├── lib/                     # Python utilities and development tools
│   ├── logger.py           # Advanced console logging with colors
│   └── utils.py            # Common utility functions
├── scripts/                # Automation and build scripts
│   └── init.py             # Project initialization and setup
├── patches/                # Custom Chromium modifications
├── docs/                   # Project-specific documentation
└── src/                    # Chromium source tree with enhancements
    ├── chrome/             # Browser UI and Chrome-specific features
    ├── content/            # Core browser engine and renderer
    ├── custom/             # 🎯 Our custom browser modifications
    ├── components/         # Reusable feature modules
    ├── services/           # Modern Mojo-based services
    ├── third_party/        # External dependencies (Blink, V8, Skia)
    ├── net/               # Advanced networking (HTTP/3, QUIC, DNS)
    ├── gpu/               # Graphics and Viz compositor
    ├── ui/                # Cross-platform UI framework
    ├── base/              # Fundamental utilities and abstractions
    └── build/             # Build system and configuration
```

### Key Integration Points
- **`src/custom/`**: Our browser enhancements and modifications
- **`lib/`**: Development tools specific to our workflow
- **`scripts/`**: Project automation and initialization
- **`patches/`**: Required patches to upstream Chromium

---

## 5. Modern Web Technologies & Features (v134+)

### Cutting-Edge Web APIs
- **WebGPU**: Next-generation graphics API with compute shader support
- **WebAssembly (WASM)**: High-performance code execution with SIMD and threading
- **Origin Private File System**: Secure file system access for web applications
- **Web Locks**: Cross-tab coordination and resource management
- **Web Streams**: Efficient data processing with backpressure handling

### Privacy & Security Innovations
- **Privacy Sandbox**: Cookieless advertising with Topics API and FLEDGE
- **Trust Tokens**: Anti-fraud mechanisms without fingerprinting
- **Attribution Reporting**: Privacy-preserving conversion measurement
- **Enhanced Site Isolation**: Protection against Spectre-style attacks

### Performance Optimizations
- **Core Web Vitals**: LCP, FID, CLS optimization at the engine level
- **Navigation API**: Smooth page transitions with shared element animations
- **Container Queries**: Responsive design without layout thrashing
- **CSS Cascade Layers**: Advanced styling control and organization

---

## 6. Development Workflow & Tools (v134+)

### Getting Started
1. **Environment Setup**: `npm run install:python` for development tools
2. **Project Initialization**: `npm run init` to fetch Chromium and dependencies
3. **Build Configuration**: `gn gen out/Default` with modern build options
4. **Compilation**: `ninja -C out/Default chrome` for browser executable

### Modern Development Tools
- **Advanced Debugging**: Chrome DevTools integration with process inspection
- **Performance Profiling**: Real-time Core Web Vitals measurement
- **Security Analysis**: Comprehensive sandbox and IPC monitoring
- **Code Navigation**: Intelligent cross-referencing and documentation

### Essential Debugging Resources
```bash
# Modern debugging pages
chrome://gpu/              # GPU capabilities and Viz status
chrome://process-internals/ # Process and service monitoring
chrome://tracing/          # Advanced performance timeline
chrome://mojo-internals/   # IPC and service inspection
chrome://components/       # Component status and versions
```

---

## 7. Learning Paths & Next Steps

### For New Developers
1. **Start Here**: [Project Layout](../getting-started/project-layout.md) - Understanding the codebase structure
2. **Architecture Deep Dive**: [Browser Components](../architecture/browser-components.md) - Modern component overview
3. **Hands-On**: [Setup & Build](../getting-started/setup-build.md) - Get your development environment running

### For Advanced Contributors
1. **Process Architecture**: [Process Model](../architecture/process-model.md) - Multi-process design and security
2. **Rendering Engine**: [Render Pipeline](../architecture/render-pipeline.md) - From HTML to pixels
3. **Communication**: [IPC Internals](../architecture/ipc-internals.md) - Mojo and modern IPC patterns

### Specialized Topics
- **Security**: [Security Model](../security/security-model.md) - Sandboxing and exploit mitigation
- **Networking**: [HTTP & Networking](../modules/networking-http.md) - Modern network stack
- **Storage**: [Storage & Cache](../modules/storage-cache.md) - Data persistence and privacy
- **JavaScript**: [V8 Integration](../modules/javascript-v8.md) - JavaScript engine internals

---

## 8. Community & Contribution

### Stay Connected
- **Chromium Blog**: Latest architectural decisions and feature announcements
- **Chrome Platform Status**: Track implementation of new web standards
- **Chromium Groups**: Specialized mailing lists for different areas of development

### Contributing Guidelines
- **Code Style**: Follow Chromium''s comprehensive style guide
- **Testing**: Implement thorough unit and integration tests
- **Documentation**: Update relevant documentation with code changes
- **Security**: Consider security implications for all modifications

### Custom Browser Development
- **Feature Planning**: Design features that integrate cleanly with Chromium''s architecture
- **Upstream Compatibility**: Maintain compatibility with Chromium updates
- **Performance**: Profile and optimize custom features for production use
- **Security**: Implement security reviews for all custom functionality

---

**Welcome to the future of browser development!** This knowledge base will guide you through the intricacies of modern Chromium architecture and help you build exceptional browsing experiences with the custom-browser project.

**Quick Links**:
- 🚀 [Get Started](../getting-started/setup-build.md)
- 🏗️ [Architecture Overview](../architecture/browser-components.md)
- 🔧 [Development Guide](../getting-started/project-layout.md)
- 🛡️ [Security Model](../security/security-model.md)
', NULL, N'introduction', N'introduction/overview', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Chromium Documentation Index', N'# Chromium docs

This directory contains [chromium project](https://www.chromium.org/Home/)
documentation in [Gitiles-flavored Markdown]. It is automatically
[rendered by Gitiles].

[Gitiles-flavored Markdown]: https://gerrit.googlesource.com/gitiles/+/master/Documentation/markdown.md
[rendered by Gitiles]: https://chromium.googlesource.com/chromium/src/+/main/docs/

**If you add new documents, please also add a link to them in the Document Index
below.**

[TOC]

## Creating Documentation

### Guidelines

*   See the [Chromium Documentation Guidelines](documentation_guidelines.md)
    and the
    [Chromium Documentation Best Practices](documentation_best_practices.md).
*   Markdown documents must follow the
    [Markdown Style
    Guide](https://chromium.googlesource.com/chromium/src/+/HEAD/styleguide/markdown/markdown.md).

### Previewing changes

#### Locally using [md_browser](../tools/md_browser/)

```bash
# in chromium checkout
./tools/md_browser/md_browser.py
```

This is only an estimate. The **gitiles** view may differ.

#### Online with Gerrit''s links to gitiles

1.  Upload a patch to gerrit, or receive a review request.
    e.g. https://chromium-review.googlesource.com/c/3362532
2.  View a specific .md file.
    e.g. https://chromium-review.googlesource.com/c/3362532/2/docs/README.md
3.  You will see something like <br>
    Base
    [preview](https://chromium.googlesource.com/chromium/src/+/ad44f6081ccc6b92479b12f1eb7e9482f474859d/docs/README.md)
    -> Patchset 3
    [preview](https://chromium.googlesource.com/chromium/src/+/refs/changes/32/3362532/3/docs/README.md)
    | DOWNLOAD <br>
    at the top left of the page. Click on the second
    "[preview](https://chromium.googlesource.com/chromium/src/+/refs/changes/32/3362532/3/docs/README.md)"
    link to open the preview for the current patch set.

This **gitiles** view is the authoritative view, exactly the same as will be
used when committed.

## Document Index

**Note**: this is not an exhaustive list of all documents.

### Checking Out and Building
*   [Linux Build Instructions](linux/build_instructions.md) - Linux
*   [Mac Build Instructions](mac_build_instructions.md) - MacOS
*   [Windows Build Instructions](windows_build_instructions.md) - Windows
*   [Android Build Instructions](android_build_instructions.md) - Android target
    (on a Linux host)
*   [Cast Build Instructions](linux/cast_build_instructions.md) - Cast target
    (on a Linux host)
*   [Cast for Android Build Instructions](android_cast_build_instructions.md) -
    Cast for Android (on a Linux host)
*   [Fuchsia Build Instructions](fuchsia/build_instructions.md) -
    Fuchsia target (on a Linux host)
*   [iOS Build Instructions](ios/build_instructions.md) - iOS target (on a MacOS
    host)
*   [Chrome OS Build Instructions](chromeos_build_instructions.md) - Chrome OS
*   [Linux Chromium ARM Recipes](linux/chromium_arm.md) - Recipes for building
    Chromium for ARM on Linux.
*   [Chrome Component Build](component_build.md) - Faster builds using more
    libraries
*   [Using the BuildRunner](using_build_runner.md) - Scripts that extract build
    stops from builders and runs them locally on a slave
*   [Cr User Manual](cr_user_manual.md) - Manual for `cr`, a tool that tries to
    hide some of the tools used for working on Chromium behind an abstraction
    layer

### Design Docs
*   See [design/README.md](design/README.md)

### Integrated Development Environment (IDE) Set Up Guides
*   [Android Studio](android_studio.md) - Android Studio for Android builds
*   [Atom](atom.md) - Atom multi-platform code editor
*   [CLion](clion.md) - CLion IDE, supports GUI debugging.
*   [Eclipse for Android](eclipse.md) - Eclipse for Android
*   [Eclipse for Linux](linux/eclipse_dev.md) - Eclipse for other platforms
    (This guide was written for Linux, but is probably usable on Windows/MacOS
    as well)
*   [EMACS Notes](emacs.md) - EMACS commands/styles/tool integrations
*   [Qt Creator](qtcreator.md) - Using Qt Creator as an IDE or GUI debugger
*   [Visual Studio Code](vscode.md) - Visual Studio Code

### Git
*   [Git Cookbook](git_cookbook.md) - A collection of git recipes for common
    tasks
*   [Git Tips](git_tips.md) - More git tips
*   [Git submodules](git_submodules.md) - Git submodule (tips, FAQ)

### Clang
*   [Clang Compiler](clang.md) - General information on the clang compiler, used
    by default on Mac and Linux
*   [Clang Tool Refactoring](clang_tool_refactoring.md) - Leveraging clang tools
    to perform refactorings that are AST-aware
*   [The Clang Static Analyzer](clang_static_analyzer.md) - How to enable static
    analysis at build time
*   [Clang Code Coverage Wrapper](clang_code_coverage_wrapper.md) - Enable Clang
    code coverage instrumentation for a subset of source files.
*   [Writing Clang Plugins](writing_clang_plugins.md) - Don''t write a clang
    plugin, but if you do, read this
*   [Updating Clang](updating_clang.md) - Updating the version of Clang used to
    build
*   [Using clang-format on Chromium C++ Code](clang_format.md) - Various ways to
    invoke clang-format on C++ code
*   [Clang Tidy](clang_tidy.md) - Support for the `clang-tidy` tool in Chromium
*   [Updating Clang Format Binaries](updating_clang_format_binaries.md) - How up
    update the clang-format binaries that come with a checkout of Chromium

### General Development
*   [Contributing to Chromium](contributing.md) - Reference workflow process for
    contributing to the Chromium code base.
*   [Commit Checklist](commit_checklist.md) - Streamlined checklist to go
    through before uploading CLs on Gerrit.
*   [Code Reviews](code_reviews.md) - Code review requirements and guidelines
*   [Dependency management](dependencies.md) - Managing dependencies (DEPS, git submodules)
*   [Respectful Code Reviews](cr_respect.md) - A guide for code reviewers
*   [Respectful Changes](cl_respect.md) - A guide for code authors
*   [Mandatory Code-Review Rollout](code_review_owners.md) - Upcoming policy changes related to code review and OWNERS
*   [LUCI Migration FAQ](luci_migration_faq.md) - FAQ on Buildbot-to-LUCI
    builder migration for Chromium
*   [Tour of Continuous Integration UI](tour_of_luci_ui.md) - A tour of our
    the user interface for LUCI, our continuous integration system
*   [Parsing Test Results](parsing_test_results.md) - An introduction for how to
    understand the results emitted by polygerrit and CI builds.
*   [Closure Compilation](closure_compilation.md) - The _Closure_ JavaScript
    compiler
*   [Threading and Tasks in Chrome](threading_and_tasks.md) - How to run tasks
    and handle thread safety in Chrome.
*   [Callback<> and Bind()](callback.md) - All about Callbacks, Closures, and
    Bind().
*   [Chromium Views UI](ui/index.md) - Working with the desktop UI framework.
*   [Views Platform Styling](ui/views/platform_style.md) - How views are styled
    to fit in different native platforms
*   [Tab Helpers](tab_helpers.md) - Using WebContents/WebContentsObserver to add
    features to browser tabs.
*   [Adding third_party Libraries](adding_to_third_party.md) - How to get code
    into third_party/
*   [Graphical Debugging Aid for Chromium Views](graphical_debugging_aid_chromium_views.md) -
    Visualizing view trees during debugging
*   [Bitmap Pipeline](bitmap_pipeline.md) - How bitmaps are moved from the
    renderer to the screen.
*   [Flag Guarding Guidelines](flag_guarding_guidelines.md) - When to use
    server controlled kill switches and A/B experiments to safely roll out
    changes.
*   [Using the Origin Trials Framework](origin_trials_integration.md) - A
    framework for conditionally enabling experimental APIs for testing.
*   [Chrome Sync](https://source.chromium.org/chromium/chromium/src/+/main:docs/website/site/developers/design-documents/sync) -
    Docs for the subsystem that allows one to sync data across devices.
*   [Ozone Overview](ozone_overview.md) - Ozone is an abstraction layer between
    the window system and low level input and graphics.
*   [Guidelines for considering branch dates in project planning](release_branch_guidance.md) -
    What to do (and not to do) around branch dates when scheduling your project
    work.
*   [Watchlists](infra/watchlists.md) - Use watchlists to get notified of CLs
    you are interested in.
*   [Shutdown](shutdown.md) - Explains the steps of Chrome shutdown, to make it
    easier to determine where to add a new shutdown operation.
*   [API Keys](api_keys.md) - When you need access to Google APIs for a custom
    build, fork, integration of stock Chromium, or are building ChromiumOS (for
    login).
*   [User Education](../components/user_education/README.md) - Create
    in-product help (IPH) and tutorials to call out Chromium features

### Testing
*   [Running and Debugging Web Tests](testing/web_tests.md)
*   [On disabling tests](testing/on_disabling_tests.md)
*   [Writing Web Tests](testing/writing_web_tests.md) - Web Tests using
    `content_shell`
*   [Web Test Expectations and Baselines](testing/web_test_expectations.md) -
    Setting expected results of web tests.
*   [Web Tests Tips](testing/web_tests_tips.md) - Best practices for web tests
*   [Web Tests with Manual Fallback](testing/web_tests_with_manual_fallback.md) -
    Writing tests that simulate manual interventions
*   [Extending the Web Test Framework](how_to_extend_web_test_framework.md)
*   [Fixing Web Test Flakiness](testing/identifying_tests_that_depend_on_order.md) -
    Diagnosing and fixing web test flakiness due to ordering dependencies.
*   [Running Web Tests using `content_shell`](testing/web_tests_in_content_shell.md) -
    Running web tests by hand.
*   [Web Platform Tests](testing/web_platform_tests.md) - Shared tests across
    browser vendors
*   [Using Crashpad with `content_shell`](testing/using_crashpad_with_content_shell.md) -
    Capture stack traces on layout test crashes without an attached debugger
*   [Test Descriptions](testing/test_descriptions.md) - Unit test targets that can be
    built, with associated descriptions.
*   [Fuzz Testing](../testing/libfuzzer/README.md) - Fuzz testing in Chromium.
*   [IPC Fuzzer](testing/ipc_fuzzer.md) - Fuzz testing of Chromium IPC interfaces.
*   [Running Chrome tests with AddressSanitizer (asan) and LeakSanitizer (lsan)](testing/linux_running_asan_tests.md) -
    Run Chrome tests with ASAN and LSAN builds to detect addressability issues and memory leaks.
*   [Code Coverage](testing/code_coverage.md) - Code coverage for Chromium.
*   [Code Coverage in Gerrit](testing/code_coverage_in_gerrit.md) - Per-CL code
    coverage in Gerrit to assist code reviews.

### Configuration Docs

*   [Configuration: Prefs, Settings, Features, Switches & Flags](configuration.md) - Explains different ways to gate a new feature.
*   [Adding a new feature flag in chrome://flags](how_to_add_your_feature_flag.md) - Quick guide to add a new feature flag to experiment your feature.
*   [Runtime Enabled Features](https://chromium.googlesource.com/chromium/src/+/main/third_party/blink/renderer/platform/RuntimeEnabledFeatures.md)
*   [Initialization of Blink runtime features in content layer](initialize_blink_features.md)
*   [Integrating a feature with the origin trials framework](origin_trials_integration.md)

### GPU-related docs
*   [GPU Pixel Wrangling](gpu/pixel_wrangling.md) - Instructions for GPU
    pixel wrangling (the GPU sheriffing rotation).
*   [Debugging GPU related code](gpu/debugging_gpu_related_code.md) - Hints for
    debugging GPU- and graphics-related code.
*   [GPU Testing](gpu/gpu_testing.md) - Description of Chromium''s GPU testing
    infrastructure.
*   [GPU Bot Details](gpu/gpu_testing_bot_details.md) - In-depth description of
    how the bots are maintained.

### Misc Linux-Specific Docs
*   [Linux Proxy Config](linux/proxy_config.md) - Network proxy sources on Linux
*   [Debugging SSL on Linux](linux/debugging_ssl.md) - Tips on debugging SSL
    code in Linux
*   [Linux Cert Management](linux/cert_management.md) - Managing X.509
    Certificates in Linux
*   [Tips for Debugging on Linux](linux/debugging.md)
*   [Linux GTK Theme Integration](linux/gtk_theme_integration.md) - Having
    Chrome match the GTK+ theme.
*   [Browser Plugins on Linux](linux/plugins.md) - A collection of links to
    information on how browser plugins work on Linux
*   [Linux Crash Dumping](linux/crash_dumping.md) - How Breakpad uploads crash
    reports to Google crash servers.
*   [Linux Minidump to Core](linux/minidump_to_core.md) - How to convert a
    Breakpad-generated minidump files to a core file readable by most debuggersx
*   [Linux Sandbox IPC](linux/sandbox_ipc.md) - The lower level UPC system used
    to route requests from the bottom of the call stack up into the browser.
*   [Linux Dev Build as Default Browser](linux/dev_build_as_default_browser.md) -
    How to configure a Dev build of Chrome as the default browser in Linux.
*   [Linux Chromium Packages](linux/chromium_packages.md) - Packages of Chromium
    browser (not Chrome) provided by some Linux distributions.
*   [`seccomp` Sandbox Crash Dumping](seccomp_sandbox_crash_dumping.md) - Notes
    on crash dumping a process running in a seccomp sandbox.
*   [Linux Password Storage](linux/password_storage.md) - Keychain integrations
    between Chromium and Linux.
*   [Linux Sublime Development](sublime_ide.md) - Using Sublime as an IDE
    for Chromium development on Linux.
*   [Building and Debugging GTK](linux/building_debug_gtk.md) - Building
    Chromium against GTK using lower optimization levels and/or more debugging
    symbols.
*   [Debugging GTK](linux/debugging_gtk.md) - Using the GTK Debug packages and
    related tools.
*   [Chroot Notes](linux/using_a_chroot.md) - Setting up a chroot to work around
    libfreetype differences in some versions of Linux.
*   [Linux Sandboxing](linux/sandboxing.md) - The Linux multi-process model to
    isolate browser components with different privileges.
*   [Zygote Process](linux/zygote.md) - How the Linux Zygote process, used to
    spawn new processes, works.
*   [Running Web Tests on Linux](testing/web_tests_linux.md) - Linux-specific
    instructions for running web tests.
*   [Linux Sysroot Images](linux/sysroot.md) - How builds use libraries on Linux
*   [Linux Hardware Video Decoding](linux/hw_video_decode.md) - Enabling
    hardware video decode codepaths on Linux

### Misc MacOS-Specific Docs
*   [Mac Debugging Tips](mac/debugging.md) - An introduction to debugging on
    Mac, as well as a collection of useful tips.
*   [Using CCache on Mac](ccache_mac.md) - Speed up builds on Mac using ccache
    with clang/ninja
*   [Cocoa tips and tricks](cocoa_tips_and_tricks.md) - A collection of idioms
    used when writing Cocoa views and controllers
*   [MacViews Release Plan](ui/views/macviews_release.md)

### Misc Windows-Specific Docs
*   [Handling cygwin rebaseall failures](cygwin_dll_remapping_failure.md)
*   [Hacking on ANGLE in Chromium](angle_in_chromium.md) - OpenGL ES 2.0 built
    on top of DirectX
*   [Windows Split DLLs](windows_split_dll.md) - Splitting `chrome.dll` into
    multiple dlls to work around toolchain limitations on Windows.
*   [Windows Native Window Occlusion Tracking](windows_native_window_occlusion_tracking.md)
*   [Windows PWA Integration](windows_pwa_integration.md) - Integration with
    Progressive Web Apps on Windows
*   [Windows Shortcut and Taskbar Handling](windows_shortcut_and_taskbar_handling.md)
*   [Windows Virtual Desktop Integration](windows_virtual_desktop_handling.md)

### Misc Android-Specific Docs
*   [Google Play Services in Chrome for Android](google_play_services.md)
*   [Accessing C++ Enums in Java](android_accessing_cpp_enums_in_java.md) - How
    to use C++-defined enums in Java code
*   [Profiling Content Shell on Android](profiling_content_shell_on_android.md) -
    Setting up profiling for `content_shell` on Android
*   [Working Remotely with Android](working_remotely_with_android.md) - Building
    on a remote machine for an Android device connected to your local machine
*   [Android Test Instructions](testing/android_test_instructions.md) - Running a build
    on an Android device or emulator.
*   [Android Debugging](android_debugging_instructions.md) - Tools and tips for
    how to debug Java and/or C/C++ code running on Android.
*   [Android Logging](android_logging.md) - How Chrome''s logging API works with
    `android.util.Log` on Android, and usage guidelines.
*   [Android Java Static Analysis](../build/android/docs/lint.md) - Catching
    Java related issues at compile time with the ''lint'' tool.
*   [Java Code Coverage](../build/android/docs/coverage.md) - Collecting code
    coverage data with the EMMA tool.
*   [Dynamic Feature Modules (DFMs)](android_dynamic_feature_modules.md) - What
    are they and how to create new ones.
*   [Other build-related Android docs](../build/android/docs/index.md)
*   [Chrome for Android UI](ui/android/overview.md) - Resources and best practices for
    developing UI

### Misc iOS-Specific Docs
*   [Continuous Build and Test Infrastructure for Chromium for iOS](ios/infra.md)
*   [Opening links in Chrome for iOS](ios/opening_links.md) - How to have your
    iOS app open links in Chrome.
*   [User Agent in Chrome for iOS](ios/user_agent.md) - Notes on User Agent
    strings using Chrome for iOS.
*   [Running iOS test suites locally](ios/testing.md)
*   [Working With Project Files in iOS](ios/working_with_files.md) - How
    to add, remove, and rename files in the iOS Chromium project.

### Misc Chrome-OS-Specific Docs
*   [Setting up captive portals and other restrictive networks](login/restrictive_networks.md)
*   [Enterprise Enrollment](enterprise/enrollment.md)
    *   [Kiosk mode and public sessions](enterprise/kiosk_public_session.md)
*   [Debugging UI in OOBE/login/lock](login/ui_debugging.md)
*   [Chrome Logging on Chrome OS](chrome_os_logging.md)
*   [Debugging tips](testing/chromeos_debugging_tips.md)

### Misc WebUI-Specific Docs
*   [WebUI Explainer](webui/webui_explainer.md) - An explanation of C++ and
    TypeScript infrastructural code for Chrome UIs implemented with web
    technologies (i.e. chrome:// URLs).
*   [Optimizing Chrome Web UIs](webui/optimizing_web_uis.md) - Notes on making
    WebUIs more performant
*   [Trusted Types on WebUI](webui/trusted_types_on_webui.md) - Tips for coding
    in WebUI with Trusted Types in mind.
*   [chrome-untrusted:// FAQ](webui/chrome_untrusted.md) - Explainer on the
    usage of the `chrome-untrusted://` scheme for hosting WebUIs that handle
    untrustworthy content.

### Media
*   [Audio Focus Handling](media/audio_focus.md) - How multiple MediaSession
    audio streams interact
*   [Autoplay of HTMLMediaElements](media/autoplay.md) - How HTMLMediaElements
    are autoplayed.
*   [Latency tracing](media/latency_tracing.md) - How to use the
    `"audio.latency"` tracing category to measure audio latency.
*   [Piranha Plant](piranha_plant.md) - Future architecture of MediaStreams
*   [Media Capture](media/capture/README.md) - Features and APIs that enable the
    browser to capture pixels and audio from itself or the underlying OS.
*   [Video Encode Accelerator Tests](media/gpu/veatest_usage.md) - How to
    use the accelerated video encoder test program.
*   [Video Decoder Tests](media/gpu/video_decoder_test_usage.md) - Running the
    video decoder tests.
*   [Video Decoder Performance Tests](media/gpu/video_decoder_perf_test_usage.md) -
    Running the video decoder performance tests.

### Accessibility
*   [Accessibility Overview](accessibility/overview.md) - Overview of
    accessibility concerns and approaches in Chromium.
*   [Accessibility Tests](accessibility/browser/tests.md) - Where to find
    accessibility-related tests in the codebase.
*   [ChromeVox on Chrome OS](accessibility/os/chromevox.md) - Enabling spoken
    feedback (ChromeVox) on Chrome OS.
*   [ChromeVox on Desktop Linux](accessibility/os/chromevox_on_desktop_linux.md) -
    Enabling spoken feedback (ChromeVox) on desktop Linux.
*   [Offscreen, Invisible and Size](accessibility/browser/offscreen.md) - How Chrome
    defines offscreen, invisible and size in the accessibility tree.
*   [Text to Speech](accessibility/browser/tts.md) - Overview of text to speech in
    Chrome and Chrome OS.
*   [BRLTTY in Chrome OS](accessibility/os/brltty.md) - Chrome OS integration with
    BRLTTY to support refreshable braille displays
*   [PATTS on Chrome OS](accessibility/os/patts.md) - Notes on the PATTS speech
    synthesis engine used on Chrome OS
*   [VoiceOver](ios/voiceover.md) - Using Apple''s VoiceOver feature with
    Chromium on iOS.

### Memory
*   [Memory Overview](memory/README.md)
*   [Heap Profiling with External Tools](memory/heap_profiling_external.md)

### Memory Infrastructure Timeline Profiling (MemoryInfra)
*   [Overview](memory-infra/README.md)
*   [GPU Profiling](memory-infra/probe-gpu.md)
*   [Adding Tracing to a Component](memory-infra/adding_memory_infra_tracing.md)
*   [Enabling Startup Tracing](memory-infra/memory_infra_startup_tracing.md)
*   [Memory Usage in CC](memory-infra/probe-cc.md)
*   [Memory Benchmarks](memory-infra/memory_benchmarks.md)
*   [Heap Profiling](memory-infra/heap_profiler.md)

### Metrics
*   [Histograms](/tools/metrics/histograms/README.md)
*   [User Actions](/tools/metrics/actions/README.md)
*   [Code review guidelines](/tools/metrics/histograms/review_guidelines.md)

### Misc
*   [Useful URLs](useful_urls.md) - A collection of links to various tools and
    dashboards
*   [ERC IRC](erc_irc.md) - Using ERC in EMACS to access IRC
*   [Kiosk Mode](kiosk_mode.md) - Simulating kiosk mode.
*   [User Handle Mapping](user_handle_mapping.md) - Names of developers across
    Chromium/IRC/Google
*   [Documentation Best Practices](documentation_best_practices.md)
*   [Documentation Guidelines](documentation_guidelines.md)
*   [Chromium Browser vs Google Chrome](chromium_browser_vs_google_chrome.md) -
    What''s the difference between _Chromium Browser_ and _Google Chrome_?
*   [Google Chrome branded builds](google_chrome_branded_builds.md)
*   [Proxy Auto Config using WPAD](proxy_auto_config.md) - How WPAD servers are
    used to automatically set proxy settings.
*   [Installing Chromium OS on VMWare](installation_at_vmware.md) - How to
    install Chromium OS on VMWare.
*   [User Data Directory](user_data_dir.md) - How the user data and cache
    directories are determined on all platforms.
*   [User Data Storage](user_data_storage.md) - Policy documentation for files in User Data.

### Mojo &amp; Services
*   [Intro to Mojo &amp; Services](mojo_and_services.md) - Quick introduction
    to Mojo and services in Chromium, with examples
*   [Mojo API Reference](/mojo/README.md) - Detailed reference documentation for
    all things Mojo
*   [Service Development Guidelines](/services/README.md) - Guidelines for
    service development in the Chromium tree
*   [Servicifying Chromium Features](servicification.md) - General advice for
    integrating new and existing subsystems into Chromium as services
*   [Converting Legacy IPC to Mojo](mojo_ipc_conversion.md) - Tips and common
    patterns for practical IPC conversion work
*   [Mojo “Style” Guide](security/mojo.md) - Recommendations for best practices
    from Mojo and IPC reviewers
*   [D-Bus Mojo Connection Service](dbus_mojo_connection_service.md) - A service
    in Chrome to bootstrap CrOS services'' Mojo connection.

### Security
*   [The Rule Of 2](security/rule-of-2.md) - An imoportant security rule when
    handling untrustworthy contents (like anything downloaded from the web).

### Speed
*   [Chrome Speed](speed/README.md) - Documentation for performance measurements and regressions in Chrome.
*   [Chrome Speed Metrics](speed_metrics/README.md) - Documentation about user experience metrics on the web and their JavaScript APIs.

### UI
*   [Chromium UI Platform](ui/index.md) - All things user interface

### What''s Up With That Transcripts

These are transcripts of [What''s Up With
That](https://www.youtube.com/playlist?list=PL9ioqAuyl6ULIdZQys3fwRxi3G3ns39Hq),
a video series of interviews with Chromium software engineers.

*   [What''s Up With Pointers - Episode 1](transcripts/wuwt-e01-pointers.md)
*   [What''s Up With DCHECKs - Episode 2](transcripts/wuwt-e02-dchecks.md)
*   [What''s Up With //content - Episode 3](transcripts/wuwt-e03-content.md)
*   [What''s Up With Tests - Episode 4](transcripts/wuwt-e04-tests.md)
*   [What''s Up With BUILD.gn - Episode 5](transcripts/wuwt-e05-build-gn.md)
*   [What''s Up With Open Source - Episode 6](transcripts/wuwt-e06-open-source.md)
*   [What''s Up With Mojo - Episode 7](transcripts/wuwt-e07-mojo.md)
*   [What''s Up With Processes - Episode 8](transcripts/wuwt-e08-processes.md)
*   [What''s Up With Site Isolation - Episode 9](transcripts/wuwt-e09-site-isolation.md)
*   [What''s Up With Web Platform - Episode 10](transcripts/wuwt-e10-web-platform.md)
*   [What''s Up With Web Standards - Episode 11](transcripts/wuwt-e11-web-standards.md)
*   [What''s Up With Base - Episode 12](transcripts/wuwt-e12-base.md)

### Probably Obsolete
*   [TPM Quick Reference](tpm_quick_ref.md) - Trusted Platform Module notes.
*   [System Hardening Features](system_hardening_features.md) - A list of
    current and planned Chrome OS security features.
*   [WebView Policies](webview_policies.md)
*   [Linux Profiling](linux/profiling.md) - How to profile Chromium on Linux
*   [Linux Graphics Pipeline](linux/graphics_pipeline.md)
*   [Linux `SUID` Sandbox](linux/suid_sandbox.md) - Sandboxing renderers using a
    SUID binary on Linux
*   [Linux `SUID` Sandbox Development](linux/suid_sandbox_development.md) -
    Development on the above system.
*   [Linux PID Namespace Support](linux/pid_namespace_support.md)
*   [Vanilla msysgit workflow](vanilla_msysgit_workflow.md) - A workflow for
    using mostly vanilla git on Windows.
*   [Old Options](chrome_settings.md) - Pre-Material Design chrome://settings
    notes.
', NULL, N'root', N'chromium-docs-index', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Setup & Build Overview', N'# Setup & Build

This guide shows you how to fetch, build, and run Chromium from source on **Linux**, **macOS**, or **Windows**.

---

## 1. Prerequisites

Before you begin, make sure you have:

- A supported OS:
  - **Linux**: Ubuntu 20.04+ or equivalent
  - **macOS**: 10.15+ (Intel or Apple Silicon)
  - **Windows**: 10 (x64)
- **Disk space**: At least 30 GB free
- **RAM**: ≥ 8 GB (16 GB+ recommended)
- **Tools**:
  - **Python 3.8+** (for build scripts)
  - **Git** (2.25+)
  - **Depot Tools** (Google’s repo of Chromium helper scripts)

### 1.1 Installing Depot Tools

```bash
# Clone Depot Tools somewhere in your PATH:
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git ~/depot_tools
export PATH="$PATH:$HOME/depot_tools"
# (Add the export line to your shell rc: ~/.bashrc, ~/.zshrc, or PowerShell profile)
```

## 2. Fetching the Source

### 2.1 Create a working directory:

```bash
mkdir -p ~/chromium && cd ~/chromium
```

### 2.2 Fetch the code:

```bash
fetch --nohooks chromium
cd src
```

### 2.3 Install additional hooks:

```bash
gclient sync --with_branch_heads --with_tags
```

## 3. Configuring Your Build

Chromium uses GN for meta-build configuration and Ninja as the build engine.

### 3.1 Generate build files:

```bash
gn gen out/Default --args=''
  is_debug=false            # or true for a debug build
  symbol_level=1            # 0=no symbols, 1=debug symbols only
  is_component_build=true   # modules are built as shared libs
''
```

### 3.2 Common args:

```text
is_debug=true               # Debug build (with assertions & logging)
is_official_build=false     # Disable Google-branded splash screens
enable_nacl=false           # Disable Native Client (optional)
remove_webcore_debug_symbols=true  # Strip extra symbols
```

### 4. Building

From the src/ directory:

```bash
ninja -C out/Default chrome
```

- -C out/Default tells Ninja where your build files live.
- chrome is the target; you can also build content_shell, browser_tests, etc.

Tip: On multi-core machines you can speed up builds:

```bash
ninja -C out/Default -j8
```

(where 8 ≈ number of CPU cores)

## 5. Running Your Build

- Linux & macOS:

```bash
out/Default/chrome        # Launches your custom build
```

- Windows (PowerShell):

```powershell
.\out\Default\chrome.exe
```

You can pass any Chromium CLI flags, for example:

```bash
out/Default/chrome --enable-logging --v=1
```

## 6. Iterating & Incremental Builds

After code changes, simply rerun:

```bash
ninja -C out/Default
```

Ninja only rebuilds what’s necessary, so incremental iterations are fast.

## 7. Common Issues & Troubleshooting

Symptom	Possible Fix
fetch is not found	Ensure depot_tools is in your PATH
gclient sync errors out	Delete src/.gclient_entries and retry
GN complains about bad args	Run gn args out/Default --list to verify flags
Out-of-memory during build	Lower -j jobs or increase swap space

## 8. Next Steps

- Dive into Project Layout: see how src/ is organized
- Explore Architecture → Process Model: understand multi-process design
- Try a Debug Build and play with logging flags

', NULL, N'getting-started', N'getting-started/setup-build', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Project Layout', N'# Project Layout

The custom-browser project is a Chromium-based browser implementation with a structured development environment. This guide provides a comprehensive tour of the project''s directories and files to help you navigate and understand the codebase effectively.

---

## 1. Top-Level Structure

```text
custom-browser/
├── .gclient                 # gclient configuration for Chromium sync
├── .gitignore               # files to ignore in Git
├── package.json             # project configuration and npm scripts
├── package-lock.json        # locked npm dependencies
├── requirements.txt         # Python dependencies
├── .npmrc                   # npm configuration
├── README.md                # project overview and setup guide
├── lib/                     # Python utilities and libraries
├── scripts/                 # automation and build scripts
├── patches/                 # Chromium patches and modifications
├── docs/                    # project documentation (currently empty)
└── src/                     # Chromium source code and custom modules
```

### Configuration Files

- **`.gclient`** - Defines how to fetch Chromium source and dependencies
- **`package.json`** - Contains project metadata, npm scripts, and custom project configurations
- **`requirements.txt`** - Python packages required for development tools
- **`.npmrc`** - npm registry and configuration settings

### Development Directories

- **`lib/`** - Python utilities for logging, development tools, and helper functions
- **`scripts/`** - Automation scripts for project initialization and build processes
- **`patches/`** - Custom patches and modifications to Chromium source
- **`docs/`** - Project documentation (expandable for future documentation)
- **`src/`** - Main Chromium source tree with custom modifications

---

## 2. The lib/ Directory

The `lib/` directory contains Python utilities that support the development workflow:

```text
lib/
├── __init__.py              # Python package initialization
├── logger.py                # Advanced colored console logging utility
├── logger_demo.py           # Demonstration of logging capabilities
├── utils.py                 # General utility functions
└── __pycache__/             # Python bytecode cache
```

### Key Components

- **`logger.py`** - Provides rich console output with progress bars, spinners, and colored logging
- **`logger_demo.py`** - Shows examples of how to use the logging system
- **`utils.py`** - Common utility functions used across the project

---

## 3. The scripts/ Directory

Contains automation scripts for project setup and development:

```text
scripts/
├── init.py                  # Main project initialization script
└── av/                      # Additional automation scripts
```

### Main Scripts

- **`init.py`** - Handles project setup, dependency fetching, and environment configuration
- **`av/`** - Directory for additional automation and validation scripts

---

## 4. The src/ Directory

After running project initialization, the Chromium source code lives in `src/`. This follows the standard Chromium layout with custom additions:

```text
src/
├── chrome/                  # Chrome browser shell & UI code
├── content/                 # Blink/V8 embedder & shared browser logic  
├── cc/                      # Compositor & layered rendering
├── gpu/                     # GPU process, drivers, and command buffer
├── net/                     # Networking stack (HTTP, QUIC, proxies)
├── ui/                      # Cross-platform UI abstraction
├── components/              # Reusable modules (autofill, payments, etc.)
├── third_party/             # External dependencies and libraries
├── tools/                   # Build-time code generation & helper scripts
├── custom/                  # Custom-core project (our modifications)
├── build/                   # Build system configuration
├── base/                    # Fundamental utilities and abstractions
├── sandbox/                 # Security sandbox implementation
├── services/                # Mojo-based services
└── out/                     # Build output directory
```

### Core Directories

- **`chrome/`** - Entry points, Chrome UI (tabs, omnibox, menus), and platform-specific code
- **`content/`** - Integrates Blink (rendering) and V8 (JavaScript), plus IPC and navigation
- **`custom/`** - **Our custom modifications and extensions to Chromium**
- **`net/`** - Implements HTTP(S), QUIC, caching, cookies, proxy resolution
- **`ui/`** - Cross-platform windowing, input events, and vector graphics

### Custom Integration

- **`custom/`** - Contains the custom-core project with our browser modifications
- **`out/`** - Generated during build process, contains compiled binaries and intermediates

---

## 5. Build Outputs & Configuration

```text
src/out/
└── Default/               # Default build configuration
    ├── obj/               # Intermediate object files
    ├── chrome.exe         # Built browser executable (Windows)
    ├── *.dll              # Shared libraries (if component build)
    └── *.ninja_log        # Build logs and timing information
```

Build outputs are generated using the GN (Generate Ninja) build system:
- Use `gn gen out/Default` to generate build files
- Use `ninja -C out/Default chrome` to build the browser

---

## 6. Project Configuration & Metadata

### Build Configuration Files

- **`BUILD.gn`** files - Scattered throughout the tree, define build targets
- **`.gn`** files - Build system templates and configuration
- **`DEPS`** - External dependency definitions and version pinning
- **`PRESUBMIT.py`** - Pre-commit hooks for code quality checks

### Project Management

- **`package.json` config section** - Defines custom project dependencies and their locations
- **`scripts/init.py`** - Automates the fetching and setup of configured projects
- **`.gclient`** - Controls Chromium source synchronization

---

## 7. Development Workflow

### Initial Setup

1. **Install dependencies**: `npm run install:python`
2. **Initialize project**: `npm run init`
3. **Configure build**: Navigate to `src/` and run `gn gen out/Default`
4. **Build browser**: `ninja -C out/Default chrome`

### Directory Navigation Tips

| Need to... | Look in... |
|------------|------------|
| Modify networking behavior | `src/net/` |
| Customize UI components | `src/ui/` or `src/chrome/browser/ui/` |
| Add browser features | `src/custom/` (our modifications) |
| Debug build issues | `src/build/` or build logs in `src/out/` |
| Work with Python tools | `lib/` directory |
| Add automation scripts | `scripts/` directory |

### Code Search and Navigation

- Use **VS Code** or your preferred IDE for local code navigation
- **Chromium Code Search**: https://source.chromium.org for upstream Chromium reference
- **grep/ripgrep**: Fast text search across the large codebase
- **BUILD.gn search**: `find . -name BUILD.gn | xargs grep <target>` to locate build definitions

---

## 8. Custom Integration Points

### Our Modifications

- **`src/custom/`** - Contains the custom-core project with our browser enhancements
- **`lib/`** - Development tools and utilities specific to our workflow
- **`scripts/`** - Automation for project management and initialization
- **`patches/`** - Any required patches to upstream Chromium code

### Development Best Practices

- Keep custom code in the `src/custom/` directory when possible
- Use the Python utilities in `lib/` for consistent logging and development experience
- Follow Chromium''s coding standards for modifications to core directories
- Document custom features and modifications in the `docs/` directory

---

**Navigation Tips:**
- Start with the `README.md` for project overview and setup
- Use `lib/logger_demo.py` to understand the development tools
- Explore `src/custom/` for our specific browser modifications
- Reference upstream Chromium documentation for core functionality understanding
', NULL, N'getting-started', N'getting-started/project-layout', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Code Directory Structure', N'# Code Directory Structure

This page expands on *Project Layout* with a detailed directory-by-directory tour of the custom-browser project''s code organization, including both the top-level project structure and the Chromium `src/` tree.

---

## Project Root Directories

### Configuration & Setup Files

- **`.gclient`** – Controls Chromium source synchronization and dependency management
- **`.gitignore`** – Specifies files to ignore in version control
- **`package.json`** – Project metadata, npm scripts, and custom project configurations
- **`package-lock.json`** – Locked npm dependency versions for reproducible builds
- **`requirements.txt`** – Python package dependencies for development tools
- **`.npmrc`** – npm registry settings and configuration

### Development Support Directories

#### `lib/` – Python Development Utilities
- **`__init__.py`** – Python package initialization file
- **`logger.py`** – Advanced colored console logging with progress bars and spinners
- **`logger_demo.py`** – Interactive demonstration of logging system capabilities
- **`utils.py`** – Common utility functions used across development scripts
- **`__pycache__/`** – Python bytecode cache (auto-generated)

#### `scripts/` – Automation & Build Scripts
- **`init.py`** – Main project initialization script that handles dependency fetching
- **`av/`** – Additional automation and validation scripts for development workflow

#### `patches/` – Chromium Modifications
- Contains custom patches and modifications to upstream Chromium code
- Organized patches for specific features or bug fixes
- Used when direct source modifications aren''t feasible

#### `docs/` – Project Documentation
- Currently empty but designated for project-specific documentation
- Future home for custom browser feature documentation and development guides

---

## The `src/` Directory Structure

After running `npm run init`, the Chromium source code is synchronized into the `src/` directory. Here''s a comprehensive breakdown:

### Core Browser Components

#### `chrome/` – Browser Shell & UI
- **`app/`** – Application entry points and main() functions
- **`browser/`** – Browser process logic, UI controllers, and feature implementations
- **`common/`** – Shared code between browser and renderer processes
- **`renderer/`** – Renderer process specific code and extensions
- **`test/`** – Chrome-specific test utilities and test data
- **Platform directories**: `android/`, `ios/`, `mac/`, `win/`, `linux/` for platform-specific code

#### `content/` – Core Browser Engine
- **`browser/`** – Browser process implementation (navigation, resource loading, IPC)
- **`renderer/`** – Renderer process implementation (DOM, JavaScript execution)
- **`common/`** – Shared interfaces and utilities between processes
- **`gpu/`** – GPU process integration code
- **`utility/`** – Utility process implementations
- **`public/`** – Public APIs for embedders

#### `custom/` – **Our Custom Modifications** 🎯
- **Custom-core project** with our browser enhancements and modifications
- Contains project-specific features and customizations
- Organized to minimize conflicts with upstream Chromium updates

### Rendering & Graphics

#### `cc/` – Compositor & Rendering Pipeline
- **`layers/`** – Layer tree implementation for hardware acceleration
- **`trees/`** – Layer tree host and commit/activation logic
- **`animation/`** – Animation system integration
- **`raster/`** – Tile rasterization and GPU texture management

#### `gpu/` – Graphics Processing
- **`command_buffer/`** – GPU command buffer implementation
- **`config/`** – GPU driver and capability detection
- **`ipc/`** – Inter-process communication for GPU operations
- **`vulkan/`** – Vulkan graphics API integration

#### `ui/` – Cross-Platform UI Toolkit
- **`base/`** – Fundamental UI primitives and utilities
- **`views/`** – Native widget toolkit abstraction
- **`gfx/`** – 2D graphics, fonts, and image handling
- **`events/`** – Input event handling and dispatch
- **Platform directories**: `gtk/`, `win/`, `cocoa/`, `ozone/` for platform UI

### Networking & Communication

#### `net/` – Networking Stack
- **`http/`** – HTTP/HTTPS protocol implementation
- **`quic/`** – QUIC protocol support
- **`dns/`** – DNS resolution and caching
- **`cookies/`** – Cookie storage and management
- **`proxy/`** – Proxy detection and configuration
- **`ssl/`** – SSL/TLS certificate handling

#### `ipc/` – Inter-Process Communication
- **Core IPC** – Message passing between browser processes
- **Mojo integration** – Modern IPC system built on Mojo
- **Security boundaries** – Process isolation and sandboxing support

### Core Infrastructure

#### `base/` – Fundamental Utilities
- **`containers/`** – Custom container classes and algorithms
- **`memory/`** – Memory management utilities and smart pointers
- **`task/`** – Task scheduling and thread pool management
- **`files/`** – File system operations and path handling
- **`strings/`** – String utilities and manipulation functions

#### `build/` – Build System Configuration
- **GN files** – Build target definitions and dependencies
- **Config files** – Compiler flags, toolchain settings
- **Scripts** – Build automation and CI/CD integration

#### `tools/` – Development Tools
- **`gn/`** – Generate Ninja build system
- **`clang/`** – Clang-based tools (format, tidy, static analysis)
- **`metrics/`** – Performance and usage metrics collection
- **`variations/`** – A/B testing and feature flag infrastructure

### Web Technologies

#### `third_party/` – External Dependencies
- **`blink/`** – Web rendering engine (WebKit fork)
- **`v8/`** – JavaScript engine
- **`skia/`** – 2D graphics library
- **`webrtc/`** – Real-time communication
- **`protobuf/`** – Protocol buffer serialization
- **`zlib/`**, **`libpng/`**, **`libjpeg/`** – Media format libraries

#### `components/` – Reusable Feature Modules
- **`autofill/`** – Form auto-completion functionality
- **`bookmarks/`** – Bookmark management
- **`history/`** – Browsing history storage and search
- **`password_manager/`** – Password storage and auto-fill
- **`payments/`** – Web payments API implementation
- **`sync/`** – Cross-device data synchronization

### Security & Sandboxing

#### `sandbox/` – Security Isolation
- **Platform-specific** – Windows, macOS, Linux sandboxing implementations
- **Policy files** – Security policy definitions and enforcement
- **IPC restrictions** – Communication constraints between processes

#### `crypto/` – Cryptographic Operations
- **Encryption/decryption** – Symmetric and asymmetric cryptography
- **Hashing** – Secure hash algorithms
- **Certificate handling** – X.509 certificate validation

### Services & Extensions

#### `services/` – Mojo-Based Services
- **`network/`** – Network service for process isolation
- **`storage/`** – Storage APIs (IndexedDB, Cache API, etc.)
- **`device/`** – Hardware device access APIs
- **`media/`** – Media capture and playback services

#### `extensions/` – Browser Extensions
- **`api/`** – Extension API implementations
- **`browser/`** – Extension host and management
- **`renderer/`** – Extension content script injection

### Build Outputs

#### `out/` – Compilation Results
- **`Default/`** – Default build configuration output
  - **`obj/`** – Intermediate object files and libraries
  - **`chrome.exe`** – Main browser executable (Windows)
  - **`*.dll`** – Dynamic libraries (Windows component builds)
  - **`resources/`** – Packaged resources and assets
  - **`locales/`** – Internationalization files

---

## Directory Relationships & Dependencies

### Layer Architecture
```
┌─────────────────────────────────────┐
│ chrome/ (Browser Shell & Features)  │
├─────────────────────────────────────┤
│ components/ (Reusable Modules)      │
├─────────────────────────────────────┤
│ content/ (Browser Engine)           │
├─────────────────────────────────────┤
│ third_party/ (External Libraries)   │
├─────────────────────────────────────┤
│ base/ (Fundamental Utilities)       │
└─────────────────────────────────────┘
```

### Custom Integration Points
- **`custom/`** integrates at the `chrome/` and `components/` level
- **`lib/`** and **`scripts/`** support development workflow
- **`patches/`** modifies any level when direct changes aren''t possible

### Development Workflow Directories
1. **Start here**: `lib/logger_demo.py` to understand tooling
2. **Project setup**: `scripts/init.py` for dependency management
3. **Custom features**: `src/custom/` for browser modifications
4. **Build configuration**: `src/build/` for compilation settings
5. **Output inspection**: `src/out/Default/` for built artifacts

---

**See also:**
- [Project Layout](project-layout.md) for high-level project organization
- [Architecture → Browser Components](../architecture/browser-components.md) for runtime component relationships
- [Setup & Build](setup-build.md) for development environment configurationructure', NULL, N'getting-started', N'getting-started/code-directory-structure', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Windows Build', N'# Checking out and Building Chromium for Windows

There are instructions for other platforms linked from the
[get the code](get_the_code.md) page.

## Instructions for Google Employees

Are you a Google employee? See
[go/building-chrome-win](https://goto.google.com/building-chrome-win) instead.

[TOC]

## System requirements

* An x86-64 machine with at least 8GB of RAM. More than 16GB is highly
  recommended.
* At least 100GB of free disk space on an NTFS-formatted hard drive. FAT32
  will not work, as some of the Git packfiles are larger than 4GB.
* An appropriate version of Visual Studio, as described below.
* Windows 10 or newer.

## Setting up Windows

### Visual Studio

Chromium requires [Visual Studio 2022](https://learn.microsoft.com/en-us/visualstudio/releases/2022/release-notes)
(>=17.0.0) to build. Visual Studio can also be used to debug Chromium.
The clang-cl compiler is used but Visual Studio''s header files, libraries, and
some tools are required. Visual Studio Community Edition should work if its
license is appropriate for you. You must install the "Desktop development with
C++" component and the "MFC/ATL support" sub-components. This can be done from
the command line by passing these arguments to the Visual Studio installer (see
below for ARM64 instructions):
```shell
$ PATH_TO_INSTALLER.EXE ^
--add Microsoft.VisualStudio.Workload.NativeDesktop ^
--add Microsoft.VisualStudio.Component.VC.ATLMFC ^
--includeRecommended
```

If you want to build for ARM64 Win32 then some extra arguments are needed. The
full set for that case is:
```shell
$ PATH_TO_INSTALLER.EXE ^
--add Microsoft.VisualStudio.Workload.NativeDesktop ^
--add Microsoft.VisualStudio.Component.VC.ATLMFC ^
--add Microsoft.VisualStudio.Component.VC.Tools.ARM64 ^
--add Microsoft.VisualStudio.Component.VC.MFC.ARM64 ^
--includeRecommended
```

Required

* [Windows 11 SDK](https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/)
version 10.0.22621.2428. This can be installed separately or by checking the
appropriate box in the Visual Studio Installer.
* (Windows 17) SDK Debugging Tools 10.0.22621.755 or higher. This version of the
Debugging tools is needed in order to support reading the large-page PDBs that
Chrome uses to allow greater-than 4 GiB PDBs. This can be installed after the
matching Windows SDK version is installed, from: Control Panel -> Programs and
Features -> Windows Software Development Kit [version] -> Change -> Debugging Tools for
Windows. If building on ARM64 Windows then you will need to manually copy the
Debuggers\x64 directory from another machine because it does not get installed
on ARM64 and is needed, whether you are building Chromium for x64 or ARM64 on
ARM64.

WARNING: On sufficiently old versions of Windows (1909 or earlier), dawn (or
related components) may fail with a D3d-related error when using the 26100 SDK.
This is because the d3dcompiler_47.dll file in the new SDK attempts to
dynamically link versions of the Universal C Runtime which are not present by
default on older systems. If you experience these errors, you can either update
the UCRT on your system, or install the 22612 SDK and use the d3dcompiler_47.dll
file included there, which statically links the UCRT.

This problem may also manifest as a DLL failure to load `__CxxFrameHandler4`.

## git installation

### Install git

If you haven''t installed `git` directly before, you can download a standalone
installer for the latest version of Git For Windows from the Git website at
https://git-scm.com/download/win.

For more information on Git for Windows (which is a separate project from Git),
see https://gitforwindows.org.

Note: if you are a Google employee, see git installation instructions at
[go/building-chrome-win](https://goto.google.com/building-chrome-win#install-updates-and-required-software).

### Update git

Note: this section is about updating a direct installation of `git` because
`depot_tools` will soon stop bundling `git`.

Updating to the latest version of `git` will depend on which version you
currently have installed. First, check your `git` version. From a cmd.exe shell,
run:
```shell
$ git version
```

| Current version | How to update to latest |
| --- | --- |
| `2.14.1` or earlier | You will need to manually uninstall Git, then follow the instructions above to [install git](#install-git) |
| `2.14.2` to `2.16.1` | In a cmd.exe shell, run: `git update` |
| `2.16.1(2)` and later | In a cmd.exe shell, run: `git update-git-for-windows` |

## Install `depot_tools`

***
**Warning:** `depot_tools` will stop bundling Git for Windows from Sep 23, 2024
onwards. To prepare for this change, Windows users should
[install Git](#git-installation) directly before then.
***

Download the
[depot_tools bundle](https://storage.googleapis.com/chrome-infra/depot_tools.zip)
and extract it somewhere (eg: C:\src\depot_tools).

***
**Warning:** **DO NOT** use drag-n-drop or copy-n-paste extract from Explorer,
this will not extract the hidden “.git” folder which is necessary for
depot_tools to autoupdate itself. You can use “Extract all…” from the
context menu though.
***

Add depot_tools to the start of your PATH (must be ahead of any installs of
Python. Note that environment variable names are case insensitive).
* Assuming you unzipped the bundle to `C:\src\depot_tools`, open:
  Control Panel → System and Security → System
* Select which PATH variable to edit.
  * If you have Administrator access, you can edit the **system** PATH. Click
  Advanced system settings → Environment Variables. Under "System variables",
  select the Path variable for editing.
  * If you don''t have Administrator access, you can edit your **user-level**
  PATH. Search for "Edit environment variables for your account". Under "User
  variables for %USER%", select the Path variable for editing.
* Modify the Path variable by adding `C:\src\depot_tools` at the front (or at
  least in front of any directory that might already have a copy of Python).
  Note: If you can only modify your user-level PATH and the system PATH has a
  Python in it, you will be out of luck.

Also, add a DEPOT_TOOLS_WIN_TOOLCHAIN environment variable in the same way, and
set it to 0. This tells depot_tools to use your locally installed version of
Visual Studio (by default, depot_tools will try to use a google-internal
version).

You may also have to set variable `vs2022_install` to your installation path of
Visual Studio 2022, like
`set vs2022_install=C:\Program Files\Microsoft Visual Studio\2022\Professional`.

From a cmd.exe shell, run:
```shell
$ gclient
```

On first run, gclient will install all the Windows-specific bits needed to work
with the code, including msysgit and python.

* If you run gclient from a non-cmd shell (e.g., cygwin, PowerShell),
  it may appear to run properly, but msysgit, python, and other tools
  may not get installed correctly.
* If you see strange errors with the file system on the first run of gclient,
  you may want to [disable Windows Indexing](https://tortoisesvn.net/faq.html#cantmove2).

## Check python install

After running gclient open a command prompt and type `where python3` and
confirm that the depot_tools `python3.bat` comes ahead of any copies of
python3.exe. Failing to ensure this can lead to overbuilding when
using gn - see [crbug.com/611087](https://crbug.com/611087).

[App Execution Aliases](https://docs.microsoft.com/en-us/windows/apps/desktop/modernize/desktop-to-uwp-extensions#alias)
can conflict with other installations of python on the system so disable
these for ''python.exe'' and ''python3.exe'' by opening ''App execution aliases''
section of Control Panel and unticking the boxes next to both of these
that point to ''App Installer''.

## Get the code

First, configure Git:

```shell
$ git config --global user.name "My Name"
$ git config --global user.email "my-name@chromium.org"
$ git config --global core.autocrlf false
$ git config --global core.filemode false
$ git config --global core.preloadindex true
$ git config --global core.fscache true
$ git config --global branch.autosetuprebase always
```

While not necessarily required it can be helpful to configure git to allow long
path support (beyond the Windows MAX_PATH limit):

```shell
git config --global core.longpaths true
```

Create a `chromium` directory for the checkout and change to it. You can call
this whatever you like and put it wherever you like, as long as the full path
has no spaces. However there are some performance benefits for Googlers in
placing the directory under `C:\src\`
(See [Why is my build slow?](https://chromium.googlesource.com/chromium/src/+/main/docs/windows_build_instructions.md#why-is-my-build-slow)).

```shell
$ mkdir chromium && cd chromium
```

Run the `fetch` tool from `depot_tools` to check out the code and its
dependencies.

```shell
$ fetch chromium
```

If you don''t want the full repo history, you can save a lot of time by
adding the `--no-history` flag to `fetch`.

Expect the command to take over an hour on even a fast connection, and many
hours on slower ones. You should configure your PC so that it doesn''t sleep
or hibernate during the fetch or else errors may occur. If errors occur while
fetching sub-repos then you can start over, or you may be able to correct them
by going to the chromium/src directory and running this command:

```shell
$ gclient sync
```

When `fetch` completes, it will have created a hidden `.gclient` file and a
directory called `src` in the working directory. The remaining instructions
assume you have switched to the `src` directory:

```shell
$ cd src
```

*Optional*: You can also [install API
keys](https://www.chromium.org/developers/how-tos/api-keys) if you want your
build to talk to some Google services, but this is not necessary for most
development and testing purposes.

## Setting up the build

Chromium uses [Ninja](https://ninja-build.org) as its main build tool along with
a tool called [GN](https://gn.googlesource.com/gn/+/main/docs/quick_start.md)
to generate `.ninja` files. You can create any number of *build directories*
with different configurations. To create a build directory:

```shell
$ gn gen out\Default
```

* You only have to run this once for each new build directory, Ninja will
  update the build files as needed.
* You can replace `Default` with another name, but
  it should be a subdirectory of `out`.
* For other build arguments, including release settings or using an alternate
  version of Visual Studio, see [GN build
  configuration](https://www.chromium.org/developers/gn-build-configuration).
  The default will be a debug component build matching the current host
  operating system and CPU.
* For more info on GN, run `gn help` on the command line or read the [quick
  start guide](https://gn.googlesource.com/gn/+/main/docs/quick_start.md).

### Faster builds

* Reduce file system overhead by excluding build directories from
  antivirus and indexing software.
* Store the build tree on a fast disk (preferably SSD).
* The more cores the better (20+ is not excessive) and lots of RAM is needed
(64 GB is not excessive).

There are some gn flags that can improve build speeds. You can specify these
in the editor that appears when you create your output directory
(`gn args out\Default`) or on the gn gen command line
(`gn gen out\Default --args="is_component_build = true is_debug = true"`).
Some helpful settings to consider using include:
* `is_component_build = true` - this uses more, smaller DLLs, and may avoid
having to relink chrome.dll after every change.
* `enable_nacl = false` - this disables Native Client which is usually not
needed for local builds.
* `target_cpu = "x86"` - x86 builds may be slightly faster than x64 builds. Note
that if you set this but don''t set `enable_nacl = false` then build times may
get worse.
* `blink_symbol_level = 0` - turn off source-level debugging for
blink to reduce build times, appropriate if you don''t plan to debug blink.
* `v8_symbol_level = 0` - turn off source-level debugging for v8 to reduce
build times, appropriate if you don''t plan to debug v8.

In order to speed up linking you can set `symbol_level = 1` or
`symbol_level = 0` - these options reduce the work the compiler and linker have
to do. With `symbol_level = 1` the compiler emits file name and line number
information so you can still do source-level debugging but there will be no
local variable or type information. With `symbol_level = 0` there is no
source-level debugging but call stacks still have function names. Changing
`symbol_level` requires recompiling everything.

When invoking ninja, specify ''chrome'' as the target to avoid building all test
binaries as well.

#### Use Reclient

In addition, Google employees should use Reclient, a distributed compilation
system. Detailed information is available internally but the relevant gn arg is:
* `use_remoteexec = true`

Google employees can visit
[go/building-chrome-win#setup-remote-execution](https://goto.google.com/building-chrome-win#setup-remote-execution)
for more information. For external contributors, Reclient does not support
Windows builds.

#### Use SCCACHE

You might be able to use [sccache](https://github.com/mozilla/sccache) for the
build process by enabling the following arguments:

* `cc_wrapper = "sccache"` - assuming the `sccache` binary is in your `%PATH%`

### Why is my build slow?

Many things can make builds slow, with Windows Defender slowing process startups
being a frequent culprit. Have you ensured that the entire Chromium src
directory is excluded from antivirus scanning (on Google machines this means
putting it in a ``src`` directory in the root of a drive)? Have you tried the
different settings listed above, including different link settings and -j
values? Have you asked on the chromium-dev mailing list to see if your build is
slower than expected for your machine''s specifications?

If you suspect that Defender is slowing your build then you can try Microsoft''s
[Performance analyzer for Microsoft Defender Antivirus](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/tune-performance-defender-antivirus?view=o365-worldwide)
to investigate in detail.

The next step is to gather some data. If you set the ``NINJA_SUMMARIZE_BUILD``
environment variable to 1 then ``autoninja`` will do three things. First, it
will set the [NINJA_STATUS](https://ninja-build.org/manual.html#_environment_variables)
environment variable so that ninja will print additional information while
building Chrome. It will show how many build processes are running at any given
time, how many build steps have completed, how many build steps have completed
per second, and how long the build has been running, as shown here:

```shell
$ set NINJA_SUMMARIZE_BUILD=1
$ autoninja -C out\Default base
ninja: Entering directory `out\Default''
[1 processes, 86/86 @ 2.7/s : 31.785s ] LINK(DLL) base.dll base.dll.lib base.dll.pdb
```

This makes slow process creation immediately obvious and lets you tell quickly
if a build is running more slowly than normal.

In addition, setting ``NINJA_SUMMARIZE_BUILD=1`` tells ``autoninja`` to print a
build performance summary when the build completes, showing the slowest build
steps and slowest build-step types, as shown here:

```shell
$ set NINJA_SUMMARIZE_BUILD=1
$ autoninja -C out\Default base
Longest build steps:
       0.1 weighted s to build obj/base/base/trace_log.obj (6.7 s elapsed time)
       0.2 weighted s to build nasm.exe, nasm.exe.pdb (0.2 s elapsed time)
       0.3 weighted s to build obj/base/base/win_util.obj (12.4 s elapsed time)
       1.2 weighted s to build base.dll, base.dll.lib (1.2 s elapsed time)
Time by build-step type:
       0.0 s weighted time to generate 6 .lib files (0.3 s elapsed time sum)
       0.1 s weighted time to generate 25 .stamp files (1.2 s elapsed time sum)
       0.2 s weighted time to generate 20 .o files (2.8 s elapsed time sum)
       1.7 s weighted time to generate 4 PEFile (linking) files (2.0 s elapsed
time sum)
      23.9 s weighted time to generate 770 .obj files (974.8 s elapsed time sum)
26.1 s weighted time (982.9 s elapsed time sum, 37.7x parallelism)
839 build steps completed, average of 32.17/s
```

The "weighted" time is the elapsed time of each build step divided by the number
of tasks that were running in parallel. This makes it an excellent approximation
of how "important" a slow step was. A link that is entirely or mostly serialized
will have a weighted time that is the same or similar to its elapsed time. A
compile that runs in parallel with 999 other compiles will have a weighted time
that is tiny.

You can also generate these reports by manually running the script after a
build:

```shell
$ python depot_tools\post_build_ninja_summary.py -C out\Default
```

Finally, setting ``NINJA_SUMMARIZE_BUILD=1`` tells autoninja to tell Ninja to
report on its own overhead by passing "-d stats". This can be helpful if, for
instance, process creation (which shows up in the StartEdge metric) is making
builds slow, perhaps due to antivirus interference due to clang-cl not being in
an excluded directory:

```shell
$ set NINJA_SUMMARIZE_BUILD=1
$ autoninja -C out\Default base
metric                  count   avg (us)        total (ms)
.ninja parse            3555    1539.4          5472.6
canonicalize str        1383032 0.0             12.7
canonicalize path       1402349 0.0             11.2
lookup node             1398245 0.0             8.1
.ninja_log load         2       118.0           0.2
.ninja_deps load        2       67.5            0.1
node stat               2516    29.6            74.4
depfile load            2       1132.0          2.3
StartEdge               88      3508.1          308.7
FinishCommand           87      1670.9          145.4
CLParser::Parse         45      1889.1          85.0
```

You can also get a visual report of the build performance with
[ninjatracing](https://github.com/nico/ninjatracing). This converts the
.ninja_log file into a .json file which can be loaded into [chrome://tracing](chrome://tracing):

```shell
$ python ninjatracing out\Default\.ninja_log >build.json
```

## Build Chromium

Build Chromium (the "chrome" target) with Ninja using the command:

```shell
$ autoninja -C out\Default chrome
```

`autoninja` is a wrapper that automatically provides optimal values for the
arguments passed to `ninja`.

You can get a list of all of the other build targets from GN by running
`gn ls out\Default` from the command line. To compile one, pass to Ninja
the GN label with no preceding "//" (so for `//chrome/test:unit_tests`
use `autoninja -C out\Default chrome/test:unit_tests`).

## Compile a single file

Ninja supports a special [syntax `^`][ninja hat syntax] to compile a single
object file specifying the source file. For example, `ninja -C
out/Default ../../base/logging.cc^` compiles `obj/base/base/logging.o`.

[ninja hat syntax]: https://ninja-build.org/manual.html#:~:text=There%20is%20also%20a%20special%20syntax%20target%5E%20for%20specifying%20a%20target%20as%20the%20first%20output%20of%20some%20rule%20containing%20the%20source%20you%20put%20in%20the%20command%20line%2C%20if%20one%20exists.%20For%20example%2C%20if%20you%20specify%20target%20as%20foo.c%5E%20then%20foo.o%20will%20get%20built%20(assuming%20you%20have%20those%20targets%20in%20your%20build%20files)

With autoninja, you need to add  `^^` to preserve the trailing `^`.

```shell
$ autoninja -C out\Default ..\..\base\logging.cc^^
```

In addition to `foo.cc^^`, Siso also supports `foo.h^^` syntax to compile
the corresponding `foo.o` if it exists.

If you run a `bash` shell, you can use the following script to ease invocation:

```shell
#!/bin/sh
files=("${@/#/..\/..\/}")
autoninja -C out/Default ${files[@]/%/^^}
```

This script assumes it is run from `src` and your output dir is `out/Default`;
it invokes `autoninja` to compile all given files. If you place it in your
`$PATH` and name it e.g. `compile`, you can invoke like this:

```shell
$ pwd  # Just to illustrate where this is run from
/c/src
$ compile base/time/time.cc base/time/time_unittest.cc
...
[0/47] 5.56s S CXX obj/base/base/time.obj
...
[2/3] 9.27s S CXX obj/base/base_unittests/time_unittest.obj
...
```

## Run Chromium

Once it is built, you can simply run the browser:

```shell
$ out\Default\chrome.exe
```

(The ".exe" suffix in the command is actually optional).

## Running test targets

Tests are split into multiple test targets based on their type and where they
exist in the directory structure. To see what target a given unit test or
browser test file corresponds to, the following command can be used:

```shell
$ gn refs out\Default --testonly=true --type=executable --all chrome\browser\ui\browser_list_unittest.cc
//chrome/test:unit_tests
```

In the example above, the target is unit_tests. The unit_tests binary can be
built by running the following command:

```shell
$ autoninja -C out\Default unit_tests
```

You can run the tests by running the unit_tests binary. You can also limit which
tests are run using the `--gtest_filter` arg, e.g.:

```shell
$ out\Default\unit_tests.exe --gtest_filter="BrowserListUnitTest.*"
```

You can find out more about GoogleTest at its
[GitHub page](https://github.com/google/googletest).

## Build an Installer

Build the `mini_installer` target to create a self-contained installer. This
has everything needed to install your browser on a machine.

```shell
$ autoninja -C out\Default mini_installer
```

See [//chrome/installer/setup/README.md](../chrome/installer/setup/README.md)
and [//chrome/installer/mini_installer/README.md](../chrome/installer/mini_installer/README.md)
for more information.

## Update your checkout

To update an existing checkout, you can run

```shell
$ git rebase-update
$ gclient sync -D
```

The first command updates the primary Chromium source repository and rebases
any of your local branches on top of tip-of-tree (aka the Git branch
`origin/main`). If you don''t want to use this script, you can also just use
`git pull` or other common Git commands to update the repo.

The second command syncs the subrepositories to the appropriate versions,
deleting those that are no longer needed, and re-runs the hooks as needed.

### Editing and Debugging With the Visual Studio IDE

You can use the Visual Studio IDE to edit and debug Chrome, with or without
Intellisense support.

#### Using Visual Studio Intellisense

If you want to use Visual Studio Intellisense when developing Chromium, use the
`--ide` command line argument to `gn gen` when you generate your output
directory (as described on the [get the code](https://dev.chromium.org/developers/how-tos/get-the-code)
page). This is an example when your checkout is `C:\src\chromium` and your
output directory is `out\Default`:

```shell
$ gn gen --ide=vs --ninja-executable=C:\src\chromium\src\third_party\ninja\ninja.exe out\Default
$ devenv out\Default\all.sln
```

GN will produce a file `all.sln` in your build directory. It will internally
use Ninja to compile while still allowing most IDE functions to work (there is
no native Visual Studio compilation mode). If you manually run "gen" again you
will need to resupply this argument, but normally GN will keep the build and
IDE files up to date automatically when you build.

The generated solution will contain several thousand projects and will be very
slow to load. Use the `--filters` argument to restrict generating project files
for only the code you''re interested in. Although this will also limit what
files appear in the project explorer, debugging will still work and you can
set breakpoints in files that you open manually. A minimal solution that will
let you compile and run Chrome in the IDE but will not show any source files
is:

```
$ gn gen --ide=vs --ninja-executable=C:\src\chromium\src\third_party\ninja\ninja.exe --filters=//chrome --no-deps out\Default
```

You can selectively add other directories you care about to the filter like so:
`--filters=//chrome;//third_party/WebKit/*;//gpu/*`.

There are other options for controlling how the solution is generated, run `gn
help gen` for the current documentation.

#### Using Visual Studio without Intellisense

It is also possible to debug and develop Chrome in Visual Studio without the
overhead of a multi-project solution file. Simply "open" your chrome.exe binary
with `File->Open->Project/Solution`, or from a Visual Studio command prompt like
so: `devenv /debugexe out\Debug\chrome.exe <your arguments>`. Many of Visual
Studio''s code exploration features will not work in this configuration, but by
installing the [VsChromium Visual Studio Extension](https://chromium.github.io/vs-chromium/)
you can get the source code to appear in the solution explorer window along
with other useful features such as code search. You can add multiple executables
of interest (base_unittests.exe, browser_tests.exe) to your solution with
`File->Add->Existing Project...` and change which one will be debugged by
right-clicking on them in `Solution Explorer` and selecting `Set as Startup
Project`. You can also change their properties, including command line
arguments, by right-clicking on them in `Solution Explorer` and selecting
`Properties`.

By default when you start debugging in Visual Studio the debugger will only
attach to the main browser process. To debug all of Chrome, install
[Microsoft''s Child Process Debugging Power Tool](https://blogs.msdn.microsoft.com/devops/2014/11/24/introducing-the-child-process-debugging-power-tool/).
You will also need to run Visual Studio as administrator, or it will silently
fail to attach to some of Chrome''s child processes.

### Improving performance of git commands

#### Configure git to use an untracked cache

Try running

```shell
$ git update-index --test-untracked-cache
```

If the output ends with `OK`, then the following may also improve performance of
`git status`:

```shell
$ git config core.untrackedCache true
```

#### Configure git to use fsmonitor

You can significantly speed up git by using [fsmonitor.](https://github.blog/2022-06-29-improve-git-monorepo-performance-with-a-file-system-monitor/)
You should enable fsmonitor in large repos, such as Chromium and v8. Enabling
it globally will launch many processes and consume excess commit/memory and
probably isn''t worthwhile. The command to enable fsmonitor in the current repo
is:

```shell
$ git config core.fsmonitor true
```
', NULL, N'development', N'development/build/windows_build_instructions', 1, GETDATE(), GETDATE(), 7);















INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Pre/Post Contract Programming', N'# Contract Programming and Pre/Post Patterns in Modern Chromium (v134+)

Contract programming is a fundamental architectural principle in modern Chromium v134+, emphasizing **preconditions**, **postconditions**, and **invariants** to ensure reliable, secure, and maintainable software components. This approach has evolved significantly with modern C++20/23 features, Mojo services, and advanced error handling patterns like `base::expected`, providing formal contracts that improve code reliability, security, and performance.

---

## Modern Contract Programming in Chromium (v134+)

Contract programming in modern Chromium has evolved to leverage cutting-edge C++20/23 features and sophisticated error handling patterns. It defines formal, precise, and verifiable interfaces for software components through:

- **Preconditions**: Conditions that must hold true before a function executes, validated using modern assertions and `base::expected`
- **Postconditions**: Conditions guaranteed after successful function execution, enforced through RAII and result validation
- **Invariants**: Properties that remain true throughout an object''s lifetime, maintained via class design and security boundaries
- **Error Contracts**: Explicit error handling using `base::expected<T, Error>` instead of exceptions
- **Capability Contracts**: Security-oriented contracts that define what operations are permitted in different contexts

### Modern Implementation Approaches (v134+)

```cpp
// Example: Modern contract programming with base::expected
class NetworkService {
 public:
  // Precondition: url must be valid, context must be authenticated
  // Postcondition: Returns success result or specific error
  base::expected<std::unique_ptr<URLLoader>, NetworkError> 
  CreateURLLoader(const GURL& url, const SecurityContext& context) {
    // Precondition validation
    if (!url.is_valid()) {
      return base::unexpected(NetworkError::kInvalidURL);
    }
    if (!context.IsAuthenticated()) {
      return base::unexpected(NetworkError::kUnauthenticated);
    }
    
    // Main operation with guaranteed postcondition
    auto loader = CreateLoaderInternal(url, context);
    DCHECK(loader);  // Postcondition: never returns null on success
    return loader;
  }
};
```

At its core, modern contract programming in Chromium relies on **compile-time validation**, **runtime assertions**, and **type-safe error handling**—ensuring that contract violations are caught early and handled gracefully.

---

## Contract Patterns in Modern Chromium (v134+)

Modern Chromium v134+ extensively implements contract programming through sophisticated architectural patterns that ensure security, performance, and reliability. This evolution goes far beyond simple assertions to include **service contracts**, **security validation**, and **cross-process guarantees**.

### Service Lifecycle Contracts

Modern Chromium''s service-oriented architecture relies heavily on contract programming for service initialization and coordination:

```cpp
// Modern service contract example
class DownloadService : public mojom::DownloadService {
 public:
  // Contract: Service must be initialized before any operations
  base::expected<void, ServiceError> Initialize(Profile* profile) {
    // Preconditions
    DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);
    if (!profile || is_initialized_) {
      return base::unexpected(ServiceError::kInvalidState);
    }
    
    // Initialization with guaranteed postconditions
    storage_partition_ = profile->GetStoragePartition();
    network_context_ = storage_partition_->GetNetworkContext();
    is_initialized_ = true;
    
    // Postcondition: Service is ready for operations
    DCHECK(IsInitialized());
    return base::ok();
  }
  
  // Contract: StartDownload requires initialized service and valid parameters
  void StartDownload(const GURL& url, 
                    mojo::PendingReceiver<mojom::DownloadController> receiver,
                    StartDownloadCallback callback) override {
    // Precondition validation
    if (!IsInitialized()) {
      std::move(callback).Run(DownloadResult::kServiceNotReady);
      return;
    }
    
    if (!url.is_valid() || !url.SchemeIsHTTPOrHTTPS()) {
      std::move(callback).Run(DownloadResult::kInvalidURL);
      return;
    }
    
    // Execute with postcondition guarantee
    StartDownloadInternal(url, std::move(receiver), std::move(callback));
  }
  
 private:
  bool IsInitialized() const { return is_initialized_ && storage_partition_; }
  
  bool is_initialized_ = false;
  StoragePartition* storage_partition_ = nullptr;
  network::NetworkContext* network_context_ = nullptr;
  SEQUENCE_CHECKER(sequence_checker_);
};
```

### Security Contract Validation

Modern Chromium implements rigorous security contracts that validate permissions and capabilities:

```cpp
// Security contract pattern for site isolation
class RenderFrameHostImpl {
 public:
  // Contract: CreateChild requires valid security context and site isolation
  base::expected<std::unique_ptr<RenderFrameHost>, SecurityError>
  CreateChildFrame(const std::string& name, 
                   const blink::FramePolicy& frame_policy) {
    // Security preconditions
    if (!GetSiteInstance()->IsValid()) {
      return base::unexpected(SecurityError::kInvalidSiteInstance);
    }
    
    if (!CanCreateChildFrame(frame_policy)) {
      return base::unexpected(SecurityError::kPermissionDenied);
    }
    
    // Create with security guarantees
    auto child_frame = CreateChildFrameInternal(name, frame_policy);
    
    // Postcondition: Child frame inherits security properties
    DCHECK_EQ(child_frame->GetSiteInstance()->GetSiteURL(),
              GetSiteInstance()->GetSiteURL());
    
    return child_frame;
  }
};
```

This ensures that each component operates within well-defined security boundaries and adheres to site isolation requirements.

---

## Benefits of Modern Contract Programming (v134+)

Modern contract programming in Chromium v134+ provides significant advantages over traditional error handling and validation approaches:

### 1. **Enhanced Security and Safety**
- **Compile-time Validation**: Contracts catch errors during compilation using C++20 concepts
- **Runtime Security**: Automatic validation of security contexts and permissions
- **Memory Safety**: RAII-based contracts prevent resource leaks and use-after-free bugs
- **Site Isolation**: Contracts enforce process boundaries and origin restrictions

### 2. **Superior Error Handling**
- **Explicit Error Contracts**: `base::expected<T, Error>` makes error paths visible and testable
- **Graceful Degradation**: Well-defined failure modes instead of crashes or undefined behavior
- **Error Propagation**: Structured error handling across service boundaries
- **Debugging Support**: Clear contract violations with detailed error information

### 3. **Performance and Reliability**
- **Early Validation**: Preconditions prevent expensive operations on invalid inputs
- **Predictable Behavior**: Postconditions guarantee consistent outcomes
- **Optimized Code Paths**: Compiler optimizations based on contract assumptions
- **Reduced Testing Overhead**: Contracts serve as executable specifications

### 4. **Developer Experience**
- **Self-Documenting Code**: Contracts make API expectations explicit
- **IDE Integration**: Better code completion and error detection
- **Refactoring Safety**: Contract violations are caught during code changes
- **Onboarding Efficiency**: New developers understand system guarantees quickly

### 5. **Cross-Process Reliability**
- **Service Contracts**: Mojo interfaces with built-in validation and capability checking
- **IPC Safety**: Type-safe communication with automatic serialization validation
- **Process Isolation**: Contracts enforce security boundaries between processes
- **Capability-Based Security**: Fine-grained permission contracts for system resources

---

## Modern C++ Contract Patterns (v134+)

Chromium v134+ leverages cutting-edge C++20/23 features to implement sophisticated contract patterns that provide compile-time safety, runtime validation, and elegant error handling.

### 1. **Concept-Based Contracts**

Modern C++ concepts enable compile-time contract validation:

```cpp
// Concept defining contract requirements
template<typename T>
concept ValidNetworkRequest = requires(T request) {
  { request.GetURL() } -> std::convertible_to<GURL>;
  { request.IsValid() } -> std::convertible_to<bool>;
  { request.GetSecurityLevel() } -> std::convertible_to<SecurityLevel>;
};

// Function with concept-based contract
template<ValidNetworkRequest RequestType>
base::expected<std::unique_ptr<URLLoader>, NetworkError>
CreateSecureLoader(const RequestType& request) {
  // Concept guarantees these methods exist and return correct types
  static_assert(ValidNetworkRequest<RequestType>);
  
  if (!request.IsValid()) {
    return base::unexpected(NetworkError::kInvalidRequest);
  }
  
  return CreateLoaderForRequest(request);
}
```

### 2. **RAII-Based Resource Contracts**

Modern RAII patterns ensure resource cleanup and state consistency:

```cpp
// RAII contract for GPU context management
class ScopedGPUContext {
 public:
  // Contract: Constructor establishes valid GPU context
  explicit ScopedGPUContext(viz::Display* display) 
      : display_(display), context_lost_(false) {
    DCHECK(display_);
    
    // Precondition: Display must be valid
    if (!display_->IsValid()) {
      context_lost_ = true;
      return;
    }
    
    // Establish GPU context with guaranteed cleanup
    context_ = display_->CreateContext();
    DCHECK(context_ || context_lost_);
  }
  
  // Contract: Destructor guarantees resource cleanup
  ~ScopedGPUContext() {
    if (context_ && !context_lost_) {
      context_->Destroy();
    }
    // Postcondition: All resources cleaned up
  }
  
  // Contract: IsValid indicates usable context
  bool IsValid() const { 
    return context_ && !context_lost_; 
  }
  
  // Contract: GetContext only valid when IsValid() == true
  viz::GLContext* GetContext() const {
    DCHECK(IsValid());  // Precondition enforcement
    return context_.get();
  }
  
 private:
  viz::Display* display_;
  std::unique_ptr<viz::GLContext> context_;
  bool context_lost_;
};
```

### 3. **Async Contract Patterns**

Modern async programming with contract guarantees:

```cpp
// Async contract pattern with base::expected
class AsyncDownloadManager {
 public:
  // Contract: Async operation with guaranteed completion callback
  void StartDownloadAsync(
      const GURL& url,
      base::OnceCallback<void(base::expected<DownloadId, DownloadError>)> callback) {
    
    // Precondition validation
    if (!url.is_valid()) {
      std::move(callback).Run(base::unexpected(DownloadError::kInvalidURL));
      return;
    }
    
    // Contract: Callback will be called exactly once
    auto wrapped_callback = base::BindOnce(
        [](base::OnceCallback<void(base::expected<DownloadId, DownloadError>)> cb,
           base::expected<DownloadId, DownloadError> result) {
          // Postcondition: Result is always valid (success or well-defined error)
          DCHECK(result.has_value() || IsValidDownloadError(result.error()));
          std::move(cb).Run(std::move(result));
        }, 
        std::move(callback));
    
    // Start async operation
    StartDownloadInternal(url, std::move(wrapped_callback));
  }
  
 private:
  static bool IsValidDownloadError(DownloadError error) {
    return error != DownloadError::kUnknown;
  }
};
```

---

## Mojo Service Contracts (v134+)

Chromium''s Mojo IPC system implements sophisticated contract patterns for cross-process communication, ensuring type safety, capability validation, and security enforcement.

### 1. **Interface Contracts**

Mojo interfaces define explicit contracts for cross-process communication:

```cpp
// Mojo interface with built-in contract validation
interface DownloadService {
  // Contract: StartDownload validates parameters and returns status
  StartDownload(url.mojom.Url download_url, 
               pending_receiver<DownloadController> controller)
      => (DownloadResult result);
  
  // Contract: Observer must be valid and will receive notifications
  AddObserver(pending_remote<DownloadObserver> observer);
  
  // Contract: Returns current downloads matching filter criteria
  GetDownloads(DownloadFilter filter) 
      => (array<DownloadInfo> downloads);
};

// Implementation with contract enforcement
class DownloadServiceImpl : public mojom::DownloadService {
 public:
  void StartDownload(
      const GURL& url,
      mojo::PendingReceiver<mojom::DownloadController> controller,
      StartDownloadCallback callback) override {
    
    // Mojo contract: Validate receiver before proceeding
    if (!controller.is_valid()) {
      std::move(callback).Run(DownloadResult::kInvalidReceiver);
      return;
    }
    
    // Security contract: Validate URL permissions
    if (!security_policy_->CanDownload(url, GetCurrentOrigin())) {
      std::move(callback).Run(DownloadResult::kPermissionDenied);
      return;
    }
    
    // Business logic with guaranteed callback
    auto download_id = CreateDownload(url);
    BindController(std::move(controller), download_id);
    std::move(callback).Run(DownloadResult::kSuccess);
  }
};
```

### 2. **Capability-Based Security Contracts**

Modern Mojo services implement capability-based security through contract validation:

```cpp
// Security contract for file system access
class FileSystemAccessService : public mojom::FileSystemAccessService {
 public:
  void RequestFileAccess(
      const base::FilePath& path,
      FileAccessMode mode,
      mojo::PendingRemote<mojom::FileAccessObserver> observer,
      RequestFileAccessCallback callback) override {
    
    // Security contract: Validate capability tokens
    auto capability_result = ValidateFileCapability(path, mode);
    if (!capability_result.has_value()) {
      std::move(callback).Run(
          FileAccessResult::FromError(capability_result.error()));
      return;
    }
    
    // Privacy contract: Check user permissions
    auto permission_result = CheckUserPermission(path, mode);
    if (!permission_result.has_value()) {
      std::move(callback).Run(
          FileAccessResult::FromError(permission_result.error()));
      return;
    }
    
    // Contract fulfilled: Grant access with monitoring
    auto access_token = GrantFileAccess(path, mode, std::move(observer));
    std::move(callback).Run(FileAccessResult::FromToken(access_token));
  }
  
 private:
  base::expected<void, SecurityError> ValidateFileCapability(
      const base::FilePath& path, FileAccessMode mode) {
    // Implement capability validation logic
    if (!IsPathAllowed(path)) {
      return base::unexpected(SecurityError::kPathNotAllowed);
    }
    if (!IsModeAllowed(mode)) {
      return base::unexpected(SecurityError::kModeNotAllowed);
    }
    return base::ok();
  }
};
```

---

## Modern Contract Implementation in Practice (v134+)

Modern Chromium v134+ implements contract patterns throughout its architecture, from browser initialization to service lifecycle management and security enforcement.

### 1. **Enhanced Browser Initialization Contracts**

The modern browser startup sequence implements sophisticated contract patterns:

```cpp
// Modern BrowserMainParts with contract validation
class ChromeBrowserMainParts : public content::BrowserMainParts {
 public:
  // Contract: PreCreateMainMessageLoop establishes prerequisites
  base::expected<void, StartupError> PreCreateMainMessageLoop() override {
    DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);
    
    // Precondition: System must meet minimum requirements
    auto system_check = ValidateSystemRequirements();
    if (!system_check.has_value()) {
      return base::unexpected(system_check.error());
    }
    
    // Initialize with guaranteed postconditions
    auto init_result = InitializePlatformSupport();
    if (!init_result.has_value()) {
      return base::unexpected(init_result.error());
    }
    
    // Postcondition: Platform support is ready
    DCHECK(IsPlatformSupportInitialized());
    return base::ok();
  }
  
  // Contract: PostCreateMainMessageLoop configures services
  void PostCreateMainMessageLoop() override {
    DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);
    DCHECK(IsPlatformSupportInitialized());  // Precondition from previous stage
    
    // Service initialization with dependency contracts
    InitializeServiceManagerWithContracts();
    
    // Postcondition: All essential services are available
    DCHECK(AreEssentialServicesReady());
  }
  
 private:
  void InitializeServiceManagerWithContracts() {
    // Each service has initialization contracts
    auto audio_result = InitializeAudioService();
    DCHECK(audio_result.has_value()) << "Audio service failed: " 
                                     << static_cast<int>(audio_result.error());
    
    auto network_result = InitializeNetworkService();
    DCHECK(network_result.has_value()) << "Network service failed: "
                                       << static_cast<int>(network_result.error());
  }
  
  SEQUENCE_CHECKER(sequence_checker_);
};
```

### 2. **Service Dependency Contracts**

Modern services implement explicit dependency contracts:

```cpp
// Service with dependency contract validation
class MediaService : public mojom::MediaService {
 public:
  // Contract: Initialize with required dependencies
  static base::expected<std::unique_ptr<MediaService>, ServiceError>
  Create(ServiceDependencies deps) {
    // Validate all required dependencies
    if (!deps.audio_manager || !deps.gpu_service || !deps.storage_partition) {
      return base::unexpected(ServiceError::kMissingDependencies);
    }
    
    auto service = base::WrapUnique(new MediaService(std::move(deps)));
    
    // Postcondition: Service is ready for media operations
    DCHECK(service->IsReadyForMediaOperations());
    return service;
  }
  
  // Contract: CreateMediaSession requires valid context
  void CreateMediaSession(
      mojo::PendingReceiver<mojom::MediaSession> receiver,
      const MediaSessionConfig& config,
      CreateMediaSessionCallback callback) override {
    
    // Precondition validation
    if (!receiver.is_valid() || !IsValidConfig(config)) {
      std::move(callback).Run(MediaSessionResult::kInvalidParameters);
      return;
    }
    
    // Security contract: Validate permissions
    if (!HasMediaPermission(config.origin)) {
      std::move(callback).Run(MediaSessionResult::kPermissionDenied);
      return;
    }
    
    // Create session with postcondition guarantee
    auto session = CreateSessionInternal(config);
    BindSession(std::move(receiver), std::move(session));
    std::move(callback).Run(MediaSessionResult::kSuccess);
  }
  
 private:
  explicit MediaService(ServiceDependencies deps) : deps_(std::move(deps)) {}
  
  bool IsReadyForMediaOperations() const {
    return deps_.audio_manager && deps_.gpu_service && deps_.storage_partition;
  }
  
  ServiceDependencies deps_;
};
```

### 3. **Performance Contract Monitoring**

Modern Chromium implements performance contracts with real-time monitoring:

```cpp
// Performance contract with Core Web Vitals validation
class RenderFrameMetricsCollector {
 public:
  // Contract: ReportMetrics validates performance thresholds
  void ReportCoreWebVitals(const CoreWebVitalsData& data) {
    DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);
    
    // Performance contract validation
    auto validation_result = ValidatePerformanceContract(data);
    if (!validation_result.has_value()) {
      ReportPerformanceViolation(validation_result.error());
      return;
    }
    
    // Update metrics with contract compliance
    UpdateMetricsWithValidation(data);
    
    // Postcondition: Metrics are consistent and within bounds
    DCHECK(AreMetricsConsistent());
  }
  
 private:
  base::expected<void, PerformanceError> ValidatePerformanceContract(
      const CoreWebVitalsData& data) {
    // Contract: LCP should be reasonable (< 10 seconds)
    if (data.largest_contentful_paint > base::Seconds(10)) {
      return base::unexpected(PerformanceError::kUnreasonableLCP);
    }
    
    // Contract: FID should be valid (>= 0)
    if (data.first_input_delay < base::TimeDelta()) {
      return base::unexpected(PerformanceError::kInvalidFID);
    }
    
    // Contract: CLS should be in valid range [0.0, 5.0]
    if (data.cumulative_layout_shift < 0.0 || 
        data.cumulative_layout_shift > 5.0) {
      return base::unexpected(PerformanceError::kInvalidCLS);
    }
    
    return base::ok();
  }
  
  SEQUENCE_CHECKER(sequence_checker_);
};
```

---

## Security Contract Patterns (v134+)

Modern Chromium implements sophisticated security contract patterns that enforce isolation, validate permissions, and prevent security vulnerabilities through compile-time and runtime guarantees.

### 1. **Site Isolation Security Contracts**

Site isolation relies on strict contracts to maintain security boundaries:

```cpp
// Site isolation contract enforcement
class SiteInstanceImpl : public SiteInstance {
 public:
  // Contract: CreateRelatedSiteInstance maintains security invariants
  static base::expected<scoped_refptr<SiteInstance>, SecurityError>
  CreateRelatedSiteInstance(BrowserContext* context, 
                           const GURL& url,
                           const SiteInstance* initiator) {
    // Security preconditions
    if (!context || !initiator) {
      return base::unexpected(SecurityError::kInvalidContext);
    }
    
    if (!url.is_valid() || url.is_empty()) {
      return base::unexpected(SecurityError::kInvalidURL);
    }
    
    // Site isolation contract: Validate cross-origin constraints
    auto site_url = GetSiteForURL(url);
    if (ShouldIsolateSite(context, site_url)) {
      auto validation_result = ValidateSiteIsolationContract(
          initiator->GetSiteURL(), site_url);
      if (!validation_result.has_value()) {
        return base::unexpected(validation_result.error());
      }
    }
    
    // Create with security guarantees
    auto site_instance = base::WrapRefCounted(
        new SiteInstanceImpl(context, site_url));
    
    // Postcondition: Site instance maintains isolation boundaries
    DCHECK(site_instance->IsIsolatedFromOtherSites());
    return site_instance;
  }
  
 private:
  static base::expected<void, SecurityError> ValidateSiteIsolationContract(
      const GURL& initiator_site, const GURL& target_site) {
    // Contract: Cross-origin navigations require proper validation
    if (url::Origin::Create(initiator_site) != url::Origin::Create(target_site)) {
      if (!CanNavigateCrossOrigin(initiator_site, target_site)) {
        return base::unexpected(SecurityError::kCrossOriginViolation);
      }
    }
    return base::ok();
  }
};
```

### 2. **Permission System Contracts**

Modern permission contracts ensure secure capability delegation:

```cpp
// Permission contract with capability validation
class PermissionManagerImpl {
 public:
  // Contract: RequestPermission validates security context and user intent
  void RequestPermission(
      blink::mojom::PermissionName permission,
      RenderFrameHost* render_frame_host,
      const GURL& requesting_origin,
      bool user_gesture,
      base::OnceCallback<void(blink::mojom::PermissionStatus)> callback) {
    
    // Security contract preconditions
    auto validation_result = ValidatePermissionRequest(
        permission, render_frame_host, requesting_origin, user_gesture);
    if (!validation_result.has_value()) {
      std::move(callback).Run(blink::mojom::PermissionStatus::DENIED);
      return;
    }
    
    // Privacy contract: Check Privacy Sandbox compliance
    if (IsPrivacySandboxPermission(permission)) {
      auto privacy_result = ValidatePrivacySandboxContract(
          requesting_origin, permission);
      if (!privacy_result.has_value()) {
        std::move(callback).Run(blink::mojom::PermissionStatus::DENIED);
        return;
      }
    }
    
    // Execute permission flow with guaranteed callback
    ProcessPermissionRequestWithContract(
        permission, render_frame_host, requesting_origin, std::move(callback));
  }
  
 private:
  base::expected<void, SecurityError> ValidatePermissionRequest(
      blink::mojom::PermissionName permission,
      RenderFrameHost* render_frame_host,
      const GURL& requesting_origin,
      bool user_gesture) {
    
    // Contract: Frame must be valid and live
    if (!render_frame_host || !render_frame_host->IsRenderFrameLive()) {
      return base::unexpected(SecurityError::kInvalidFrame);
    }
    
    // Contract: Powerful features require user gesture
    if (IsPowerfulFeature(permission) && !user_gesture) {
      return base::unexpected(SecurityError::kNoUserGesture);
    }
    
    // Contract: Origin must match frame''s committed origin
    auto frame_origin = render_frame_host->GetLastCommittedOrigin();
    if (frame_origin != url::Origin::Create(requesting_origin)) {
      return base::unexpected(SecurityError::kOriginMismatch);
    }
    
    return base::ok();
  }
  
  base::expected<void, PrivacyError> ValidatePrivacySandboxContract(
      const GURL& origin, blink::mojom::PermissionName permission) {
    // Privacy contract: Validate Topics API usage
    if (permission == blink::mojom::PermissionName::TOPICS_API) {
      if (!IsTopicsAPIAllowed(origin)) {
        return base::unexpected(PrivacyError::kTopicsNotAllowed);
      }
    }
    
    // Privacy contract: Validate FLEDGE usage
    if (permission == blink::mojom::PermissionName::FLEDGE_API) {
      if (!IsFledgeAPIAllowed(origin)) {
        return base::unexpected(PrivacyError::kFledgeNotAllowed);
      }
    }
    
    return base::ok();
  }
};
```

### 3. **Mojo Security Contracts**

Cross-process security contracts ensure safe IPC communication:

```cpp
// Mojo security contract for sensitive operations
class CryptographyService : public mojom::CryptographyService {
 public:
  // Contract: EncryptData validates security context and data integrity
  void EncryptData(
      const std::vector<uint8_t>& plaintext,
      const std::string& key_id,
      mojo::PendingRemote<mojom::CryptographyObserver> observer,
      EncryptDataCallback callback) override {
    
    // Security contract: Validate caller privileges
    auto security_result = ValidateCallerSecurityContract();
    if (!security_result.has_value()) {
      std::move(callback).Run(CryptographyResult::FromError(security_result.error()));
      return;
    }
    
    // Data contract: Validate input parameters
    if (plaintext.empty() || key_id.empty()) {
      std::move(callback).Run(CryptographyResult::FromError(
          CryptographyError::kInvalidParameters));
      return;
    }
    
    // Key management contract: Validate key access
    auto key_result = ValidateKeyAccessContract(key_id);
    if (!key_result.has_value()) {
      std::move(callback).Run(CryptographyResult::FromError(key_result.error()));
      return;
    }
    
    // Execute with security monitoring
    PerformEncryptionWithMonitoring(
        plaintext, key_id, std::move(observer), std::move(callback));
  }
  
 private:
  base::expected<void, SecurityError> ValidateCallerSecurityContract() {
    // Contract: Caller must have cryptography capability
    auto* current_context = mojo::GetMessageContext();
    if (!current_context || !current_context->HasCapability("cryptography")) {
      return base::unexpected(SecurityError::kInsufficientCapabilities);
    }
    
    // Contract: Process must be properly sandboxed
    if (!IsCallerProperlySandboxed()) {
      return base::unexpected(SecurityError::kSandboxViolation);
    }
    
    return base::ok();
  }
  
  base::expected<void, CryptographyError> ValidateKeyAccessContract(
      const std::string& key_id) {
    // Contract: Key must exist and be accessible
    if (!key_store_->KeyExists(key_id)) {
      return base::unexpected(CryptographyError::kKeyNotFound);
    }
    
    // Contract: Caller must have permission for this key
    if (!key_store_->CanAccessKey(key_id, GetCallerIdentity())) {
      return base::unexpected(CryptographyError::kKeyAccessDenied);
    }
    
    return base::ok();
  }
};
```

---

## Performance Contract Patterns (v134+)

Modern Chromium implements performance contracts that ensure optimal user experience through measurable guarantees and real-time monitoring.

### 1. **Core Web Vitals Performance Contracts**

Performance contracts ensure adherence to Core Web Vitals standards:

```cpp
// Core Web Vitals contract enforcement
class PagePerformanceManager {
 public:
  // Contract: TrackPageLoad ensures performance metrics collection
  void TrackPageLoad(content::WebContents* web_contents,
                    const GURL& url,
                    base::OnceCallback<void(PerformanceReport)> callback) {
    DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);
    
    // Performance contract preconditions
    if (!web_contents || !url.is_valid()) {
      std::move(callback).Run(PerformanceReport::CreateError(
          PerformanceError::kInvalidParameters));
      return;
    }
    
    // Contract: Start performance monitoring with guaranteed reporting
    auto tracker = CreatePerformanceTracker(web_contents, url);
    tracker->SetPerformanceContract(CreateCoreWebVitalsContract());
    
    // Contract: Callback will be called with complete metrics
    auto wrapped_callback = base::BindOnce(
        &PagePerformanceManager::ValidateAndReportPerformance,
        weak_factory_.GetWeakPtr(), std::move(callback));
    
    tracker->StartTracking(std::move(wrapped_callback));
  }
  
 private:
  PerformanceContract CreateCoreWebVitalsContract() {
    PerformanceContract contract;
    
    // LCP contract: Largest Contentful Paint < 2.5s for good rating
    contract.AddMetricContract(
        MetricType::kLargestContentfulPaint,
        MetricThreshold{
          .good_threshold = base::Milliseconds(2500),
          .needs_improvement_threshold = base::Milliseconds(4000),
          .violation_action = ViolationAction::kReportAndOptimize
        });
    
    // FID contract: First Input Delay < 100ms for good rating
    contract.AddMetricContract(
        MetricType::kFirstInputDelay,
        MetricThreshold{
          .good_threshold = base::Milliseconds(100),
          .needs_improvement_threshold = base::Milliseconds(300),
          .violation_action = ViolationAction::kReportAndOptimize
        });
    
    // CLS contract: Cumulative Layout Shift < 0.1 for good rating
    contract.AddMetricContract(
        MetricType::kCumulativeLayoutShift,
        MetricThreshold{
          .good_threshold = 0.1,
          .needs_improvement_threshold = 0.25,
          .violation_action = ViolationAction::kReportAndOptimize
        });
    
    return contract;
  }
  
  void ValidateAndReportPerformance(
      base::OnceCallback<void(PerformanceReport)> callback,
      const PerformanceMetrics& metrics) {
    
    // Contract validation: All required metrics must be present
    auto validation_result = ValidateMetricsCompleteness(metrics);
    if (!validation_result.has_value()) {
      std::move(callback).Run(PerformanceReport::CreateError(
          validation_result.error()));
      return;
    }
    
    // Performance contract evaluation
    auto report = EvaluatePerformanceContracts(metrics);
    
    // Contract: Report violations for optimization
    if (report.HasViolations()) {
      TriggerPerformanceOptimization(report.GetViolations());
    }
    
    std::move(callback).Run(std::move(report));
  }
  
  SEQUENCE_CHECKER(sequence_checker_);
  base::WeakPtrFactory<PagePerformanceManager> weak_factory_{this};
};
```

### 2. **Memory Usage Contracts**

Memory management contracts prevent resource exhaustion:

```cpp
// Memory usage contract with automatic enforcement
class MemoryManager {
 public:
  // Contract: AllocateMemory enforces memory limits and tracking
  base::expected<std::unique_ptr<MemoryBlock>, MemoryError>
  AllocateMemory(size_t size, MemoryPriority priority) {
    DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);
    
    // Memory contract preconditions
    if (size == 0 || size > kMaxAllocationSize) {
      return base::unexpected(MemoryError::kInvalidSize);
    }
    
    // Contract: Check memory availability before allocation
    auto availability_check = CheckMemoryAvailability(size, priority);
    if (!availability_check.has_value()) {
      return base::unexpected(availability_check.error());
    }
    
    // Contract: Track allocation for lifecycle management
    auto memory_block = AllocateWithTracking(size, priority);
    if (!memory_block) {
      return base::unexpected(MemoryError::kAllocationFailed);
    }
    
    // Postcondition: Memory is tracked and within limits
    DCHECK(IsMemoryWithinLimits());
    return memory_block;
  }
  
  // Contract: Memory pressure triggers managed cleanup
  void HandleMemoryPressure(MemoryPressureLevel level) {
    DCHECK_CALLED_ON_VALID_SEQUENCE(sequence_checker_);
    
    switch (level) {
      case MemoryPressureLevel::kModerate:
        // Contract: Free low-priority allocations
        FreeLowPriorityMemory();
        break;
        
      case MemoryPressureLevel::kCritical:
        // Contract: Aggressive cleanup to prevent OOM
        FreeNonEssentialMemory();
        TriggerGarbageCollection();
        break;
    }
    
    // Postcondition: Memory usage reduced appropriately
    DCHECK(IsMemoryUsageAppropriate(level));
  }
  
 private:
  base::expected<void, MemoryError> CheckMemoryAvailability(
      size_t size, MemoryPriority priority) {
    
    // Contract: High-priority allocations have reserved capacity
    size_t available_memory = GetAvailableMemory();
    if (priority == MemoryPriority::kHigh) {
      if (size > available_memory + GetReservedMemory()) {
        return base::unexpected(MemoryError::kInsufficientMemory);
      }
    } else {
      if (size > available_memory) {
        return base::unexpected(MemoryError::kInsufficientMemory);
      }
    }
    
    // Contract: Total memory usage stays within system limits
    if (GetTotalMemoryUsage() + size > GetMemoryLimit()) {
      return base::unexpected(MemoryError::kMemoryLimitExceeded);
    }
    
    return base::ok();
  }
  
  SEQUENCE_CHECKER(sequence_checker_);
};
```

### 3. **Thread Safety Contracts**

Thread safety contracts ensure correct concurrent behavior:

```cpp
// Thread safety contract with sequence validation
class ThreadSafeCache {
 public:
  // Contract: Get operation is thread-safe and returns valid data
  base::expected<CacheEntry, CacheError> Get(const std::string& key) {
    base::AutoLock lock(cache_lock_);
    
    // Thread safety contract: Validate key before access
    if (key.empty()) {
      return base::unexpected(CacheError::kInvalidKey);
    }
    
    // Contract: Return valid entry or explicit miss
    auto it = cache_entries_.find(key);
    if (it == cache_entries_.end()) {
      return base::unexpected(CacheError::kEntryNotFound);
    }
    
    // Contract: Validate entry freshness
    if (IsEntryExpired(it->second)) {
      cache_entries_.erase(it);
      return base::unexpected(CacheError::kEntryExpired);
    }
    
    // Postcondition: Return valid, fresh cache entry
    return it->second;
  }
  
  // Contract: Set operation maintains cache invariants
  void Set(const std::string& key, CacheEntry entry) {
    base::AutoLock lock(cache_lock_);
    
    // Contract: Enforce cache size limits
    if (cache_entries_.size() >= kMaxCacheSize) {
      EvictLeastRecentlyUsed();
    }
    
    // Contract: Entry is valid and properly timestamped
    entry.access_time = base::TimeTicks::GETDATE();
    cache_entries_[key] = std::move(entry);
    
    // Postcondition: Cache remains within size limits
    DCHECK_LE(cache_entries_.size(), kMaxCacheSize);
  }
  
 private:
  mutable base::Lock cache_lock_;
  std::unordered_map<std::string, CacheEntry> cache_entries_ GUARDED_BY(cache_lock_);
  static constexpr size_t kMaxCacheSize = 1000;
};
```

---

## Testing Contract Patterns (v134+)

Modern Chromium employs sophisticated testing strategies that validate contract adherence, ensuring that preconditions, postconditions, and error handling work correctly across all scenarios.

### 1. **Google Mock Contract Validation**

Contract testing with Google Mock ensures proper validation and error handling:

```cpp
// Mock class for testing contract validation
class MockNetworkService : public NetworkService {
 public:
  MOCK_METHOD(base::expected<std::unique_ptr<URLLoader>, NetworkError>,
              CreateURLLoader,
              (const GURL& url, const SecurityContext& context),
              (override));
  
  MOCK_METHOD(void, 
              ValidateSecurityContext,
              (const SecurityContext& context),
              (const));
};

// Test fixture for contract validation
class NetworkServiceContractTest : public testing::Test {
 protected:
  void SetUp() override {
    mock_network_service_ = std::make_unique<MockNetworkService>();
    security_context_ = CreateValidSecurityContext();
  }
  
  std::unique_ptr<MockNetworkService> mock_network_service_;
  SecurityContext security_context_;
};

// Test contract precondition violations
TEST_F(NetworkServiceContractTest, CreateURLLoaderRejectsInvalidURL) {
  const GURL invalid_url("");  // Empty URL violates precondition
  
  // Expect contract violation to be handled gracefully
  EXPECT_CALL(*mock_network_service_, CreateURLLoader(invalid_url, security_context_))
      .WillOnce(testing::Return(base::unexpected(NetworkError::kInvalidURL)));
  
  auto result = mock_network_service_->CreateURLLoader(invalid_url, security_context_);
  
  // Verify contract enforcement
  ASSERT_FALSE(result.has_value());
  EXPECT_EQ(result.error(), NetworkError::kInvalidURL);
}

// Test contract postcondition guarantees
TEST_F(NetworkServiceContractTest, CreateURLLoaderGuaranteesValidResult) {
  const GURL valid_url("https://example.com");
  auto expected_loader = std::make_unique<MockURLLoader>();
  auto* expected_loader_ptr = expected_loader.get();
  
  // Mock successful creation with postcondition guarantee
  EXPECT_CALL(*mock_network_service_, CreateURLLoader(valid_url, security_context_))
      .WillOnce(testing::Return(testing::ByMove(std::move(expected_loader))));
  
  auto result = mock_network_service_->CreateURLLoader(valid_url, security_context_);
  
  // Verify postcondition: successful result contains valid loader
  ASSERT_TRUE(result.has_value());
  EXPECT_EQ(result.value().get(), expected_loader_ptr);
  EXPECT_NE(result.value().get(), nullptr);  // Postcondition: never null on success
}

// Test error contract propagation
TEST_F(NetworkServiceContractTest, ErrorContractsPropagateCorrectly) {
  const GURL valid_url("https://example.com");
  SecurityContext invalid_context;  // Unauthenticated context
  
  // Test each possible error condition
  std::vector<std::pair<SecurityContext, NetworkError>> error_cases = {
    {invalid_context, NetworkError::kUnauthenticated},
    {CreateExpiredSecurityContext(), NetworkError::kExpiredCredentials},
    {CreateRevokedSecurityContext(), NetworkError::kAccessRevoked}
  };
  
  for (const auto& [context, expected_error] : error_cases) {
    EXPECT_CALL(*mock_network_service_, CreateURLLoader(valid_url, context))
        .WillOnce(testing::Return(base::unexpected(expected_error)));
    
    auto result = mock_network_service_->CreateURLLoader(valid_url, context);
    
    ASSERT_FALSE(result.has_value()) << "Expected error for context type";
    EXPECT_EQ(result.error(), expected_error) << "Error contract mismatch";
  }
}
```

### 2. **Contract Violation Testing**

Systematic testing of contract violations ensures robust error handling:

```cpp
// Test fixture for contract violation scenarios
class ContractViolationTest : public testing::Test {
 protected:
  void SetUp() override {
    download_service_ = std::make_unique<DownloadServiceImpl>(
        CreateTestProfile());
  }
  
  // Helper method to create invalid test scenarios
  template<typename ContractViolation>
  void TestContractViolation(ContractViolation violation,
                            const std::string& expected_error_message) {
    // Enable contract violation reporting for testing
    base::test::ScopedFeatureList feature_list;
    feature_list.InitAndEnableFeature(features::kStrictContractValidation);
    
    // Set up violation detection
    bool violation_detected = false;
    std::string violation_message;
    
    SetContractViolationHandler([&](const std::string& message) {
      violation_detected = true;
      violation_message = message;
    });
    
    // Execute the violation scenario
    violation();
    
    // Verify contract violation was detected
    EXPECT_TRUE(violation_detected) << "Contract violation not detected";
    EXPECT_THAT(violation_message, testing::HasSubstr(expected_error_message));
  }
  
  std::unique_ptr<DownloadServiceImpl> download_service_;
};

TEST_F(ContractViolationTest, DetectsInvalidStateTransition) {
  TestContractViolation(
    [this]() {
      // Violate contract: Call StartDownload on uninitialized service
      download_service_->StartDownload(
          GURL("https://example.com/file.pdf"), 
          mojo::NullReceiver(), 
          base::DoNothing());
    },
    "Service not initialized"
  );
}

TEST_F(ContractViolationTest, DetectsResourceLeaks) {
  TestContractViolation(
    [this]() {
      // Violate contract: Create resource without proper cleanup
      auto resource = download_service_->CreateTempResource();
      // Intentionally don''t clean up to trigger contract violation
    },
    "Resource leak detected"
  );
}
```

### 3. **Integration Contract Testing**

End-to-end testing of contract interactions across components:

```cpp
// Integration test for cross-service contract validation
class ServiceContractIntegrationTest : public testing::Test {
 protected:
  void SetUp() override {
    // Set up service chain with contract validation enabled
    network_service_ = CreateNetworkServiceWithContracts();
    download_service_ = CreateDownloadServiceWithContracts(network_service_.get());
    storage_service_ = CreateStorageServiceWithContracts();
    
    // Enable contract monitoring across services
    EnableCrossServiceContractMonitoring();
  }
  
  void TearDown() override {
    // Verify all contracts were maintained during test
    VerifyNoContractViolations();
  }
  
  std::unique_ptr<NetworkService> network_service_;
  std::unique_ptr<DownloadService> download_service_;
  std::unique_ptr<StorageService> storage_service_;
};

TEST_F(ServiceContractIntegrationTest, DownloadFlowMaintainsAllContracts) {
  const GURL download_url("https://example.com/large-file.zip");
  
  // Contract: Download request should succeed with valid parameters
  base::RunLoop download_started_loop;
  download_service_->StartDownload(
      download_url,
      CreateMockDownloadReceiver(),
      base::BindLambdaForTesting([&](DownloadResult result) {
        EXPECT_EQ(result, DownloadResult::kSuccess);
        download_started_loop.Quit();
      }));
  
  download_started_loop.Run();
  
  // Contract: Network service should receive valid requests
  EXPECT_TRUE(network_service_->ReceivedValidRequest(download_url));
  
  // Contract: Storage service should be prepared for data
  EXPECT_TRUE(storage_service_->HasAvailableSpace());
  
  // Simulate download progress with contract validation
  SimulateDownloadProgressWithContracts();
  
  // Contract: All services should maintain their invariants
  EXPECT_TRUE(network_service_->MaintainsInvariants());
  EXPECT_TRUE(download_service_->MaintainsInvariants());
  EXPECT_TRUE(storage_service_->MaintainsInvariants());
}
```

---

## Real-World v134+ Examples

Modern Chromium''s contract programming patterns are implemented throughout the codebase, providing concrete examples of sophisticated contract enforcement.

### 1. **RenderFrameHost Contract Implementation**

Real-world security contract in frame management:

```cpp
// Simplified from content/browser/renderer_host/render_frame_host_impl.cc
class RenderFrameHostImpl : public RenderFrameHost {
 public:
  // Contract: CreateChildFrame maintains site isolation invariants
  RenderFrameHost* CreateChildFrame(
      int new_routing_id,
      mojo::PendingAssociatedRemote<mojom::Frame> frame_remote,
      blink::mojom::PolicyContainerBindParamsPtr policy_container_bind_params,
      blink::mojom::TreeScopeType scope,
      const std::string& frame_name,
      const std::string& frame_unique_name,
      bool is_created_by_script,
      const blink::LocalFrameToken& frame_token,
      const base::UnguessableToken& devtools_frame_token,
      const blink::FramePolicy& frame_policy) {
    
    // Security contract: Validate frame creation parameters
    if (!ValidateFrameCreationContract(new_routing_id, frame_token, frame_policy)) {
      RecordContractViolation("CreateChildFrame: Invalid parameters");
      return nullptr;
    }
    
    // Site isolation contract: Ensure proper origin separation
    auto site_instance_result = GetSiteInstanceForChildFrame(frame_policy);
    if (!site_instance_result.has_value()) {
      RecordContractViolation("CreateChildFrame: Site isolation violation");
      return nullptr;
    }
    
    // Create child with contract guarantees
    auto child_frame = CreateChildFrameInternal(
        new_routing_id, std::move(frame_remote), scope, frame_name,
        frame_unique_name, is_created_by_script, frame_token,
        devtools_frame_token, frame_policy, site_instance_result.value());
    
    // Postcondition: Child frame inherits security properties
    DCHECK(child_frame->GetSiteInstance()->IsRelatedSiteInstance(GetSiteInstance()));
    
    return child_frame;
  }
  
 private:
  bool ValidateFrameCreationContract(int routing_id,
                                   const blink::LocalFrameToken& frame_token,
                                   const blink::FramePolicy& frame_policy) {
    // Contract: Routing ID must be valid and unique
    if (routing_id == MSG_ROUTING_NONE || 
        RenderFrameHostImpl::FromID(GetProcess()->GetID(), routing_id)) {
      return false;
    }
    
    // Contract: Frame token must be valid and unique
    if (frame_token.is_empty() || 
        RenderFrameHostImpl::FromFrameToken(GetProcess()->GetID(), frame_token)) {
      return false;
    }
    
    // Contract: Frame policy must be valid for current context
    return ValidateFramePolicy(frame_policy);
  }
};
```

### 2. **URLLoaderFactory Security Contracts**

Real-world network security contract implementation:

```cpp
// Simplified from services/network/url_loader_factory.cc
class URLLoaderFactoryImpl : public mojom::URLLoaderFactory {
 public:
  void CreateLoaderAndStart(
      mojo::PendingReceiver<mojom::URLLoader> receiver,
      int32_t request_id,
      uint32_t options,
      const ResourceRequest& url_request,
      mojo::PendingRemote<mojom::URLLoaderClient> client,
      const net::MutableNetworkTrafficAnnotationTag& traffic_annotation) override {
    
    // Security contract: Validate request against factory parameters
    auto validation_result = ValidateRequestContract(url_request, options);
    if (!validation_result.has_value()) {
      RecordSecurityViolation("URLLoaderFactory", validation_result.error());
      client->OnComplete(network::URLLoaderCompletionStatus(
          validation_result.error()));
      return;
    }
    
    // CORS contract: Validate cross-origin requests
    if (IsCrossOriginRequest(url_request)) {
      auto cors_result = ValidateCORSContract(url_request);
      if (!cors_result.has_value()) {
        client->OnComplete(network::URLLoaderCompletionStatus(
            net::ERR_BLOCKED_BY_CLIENT));
        return;
      }
    }
    
    // Create loader with security guarantees
    auto loader = std::make_unique<URLLoaderImpl>(
        url_request, std::move(client), traffic_annotation, factory_params_);
    
    auto* raw_loader = loader.get();
    mojo::MakeSelfOwnedReceiver(std::move(loader), std::move(receiver));
    
    // Postcondition: Loader is properly configured and secured
    DCHECK(raw_loader->IsProperlyConfigured());
  }
  
 private:
  base::expected<void, net::Error> ValidateRequestContract(
      const ResourceRequest& request, uint32_t options) {
    
    // Contract: URL must be valid and allowed
    if (!request.url.is_valid()) {
      return base::unexpected(net::ERR_INVALID_URL);
    }
    
    // Contract: Respect factory''s origin restrictions
    if (factory_params_->request_initiator_origin_lock.has_value()) {
      auto expected_origin = factory_params_->request_initiator_origin_lock.value();
      if (request.request_initiator != expected_origin) {
        return base::unexpected(net::ERR_BLOCKED_BY_CLIENT);
      }
    }
    
    // Contract: Validate resource type permissions
    if (!CanRequestResourceType(request.resource_type)) {
      return base::unexpected(net::ERR_BLOCKED_BY_CLIENT);
    }
    
    return base::ok();
  }
};
```

---

## Modern Contract Programming Best Practices (v134+)

Based on Chromium''s extensive use of contract programming, here are the essential best practices for implementing robust contracts:

### 1. **Contract Design Principles**

- **Explicit Error Contracts**: Use `base::expected<T, Error>` to make error conditions explicit and testable
- **Fail-Fast Validation**: Validate preconditions early and fail fast with clear error messages
- **Invariant Maintenance**: Design classes that maintain their invariants automatically through RAII
- **Security by Default**: Implement security contracts that deny by default and require explicit permission
- **Performance Awareness**: Design contracts that can be optimized away in release builds when appropriate

### 2. **Implementation Guidelines**

- **Use Modern C++ Features**: Leverage concepts, `base::expected`, and RAII for robust contract implementation
- **Sequence Checking**: Use `SEQUENCE_CHECKER` to enforce single-threaded access contracts
- **Memory Safety**: Implement contracts that prevent use-after-free and memory leaks
- **Cross-Process Contracts**: Use Mojo interfaces to enforce contracts across process boundaries
- **Testing Coverage**: Write comprehensive tests that validate contract adherence and violation handling

### 3. **Error Handling Best Practices**

- **Structured Error Types**: Define specific error types that provide actionable information
- **Error Propagation**: Use `base::expected` to propagate errors up the call stack cleanly
- **Graceful Degradation**: Design contracts that allow graceful degradation when possible
- **Security Response**: Implement contracts that respond appropriately to security violations
- **Performance Monitoring**: Monitor contract violations for performance optimization opportunities

---

## Why Contract Programming is Essential in Modern Chromium (v134+)

Modern contract programming in Chromium v134+ goes far beyond traditional assertions, providing a comprehensive framework for building reliable, secure, and performant software:

### **Foundation for Security**
- **Zero-Trust Architecture**: Contracts enforce security boundaries at every interface
- **Site Isolation Guarantees**: Formal contracts prevent cross-origin security violations
- **Permission Validation**: Explicit contracts govern capability delegation and resource access
- **Privacy Protection**: Contracts ensure Privacy Sandbox APIs operate within defined boundaries

### **Performance and Reliability**
- **Early Error Detection**: Contract violations are caught at development time, not in production
- **Optimized Code Paths**: Compiler optimizations based on contract assumptions improve performance
- **Predictable Behavior**: Postconditions guarantee consistent system state across all scenarios
- **Resource Management**: RAII-based contracts prevent memory leaks and resource exhaustion

### **Developer Productivity**
- **Self-Documenting APIs**: Contracts make interface expectations explicit and verifiable
- **Refactoring Safety**: Contract violations are detected automatically during code changes
- **Testing Efficiency**: Contracts serve as executable specifications, reducing testing overhead
- **Cross-Team Collaboration**: Clear contracts enable safe integration across team boundaries

### **Modern C++ Advantages**
- **Type Safety**: `base::expected<T, Error>` provides compile-time error handling validation
- **Async Safety**: Contracts ensure proper callback execution and resource cleanup in async operations
- **Thread Safety**: Sequence checkers and lock annotations prevent concurrency bugs
- **Service Integration**: Mojo contracts enable safe cross-process communication with capability validation

---

## Conclusion: Contract Programming as Chromium''s Architectural Foundation

Contract programming has evolved from a simple pre/post pattern into a sophisticated architectural foundation that underpins modern Chromium v134+. Through the integration of cutting-edge C++20/23 features, advanced error handling with `base::expected`, and comprehensive security validation, contract programming enables Chromium to maintain its position as the world''s most secure and performant browser engine.

### **Key Achievements**

**Security Excellence**: Contract programming provides the foundation for Chromium''s advanced security model, including site isolation, Privacy Sandbox compliance, and capability-based resource access. Every security boundary is enforced through explicit contracts that are validated at compile-time and runtime.

**Performance Leadership**: By establishing clear performance contracts with Core Web Vitals integration, memory usage limits, and thread safety guarantees, Chromium maintains its performance leadership while handling billions of web requests daily.

**Developer Experience**: Modern contract patterns with `base::expected`, concepts, and RAII enable developers to write safer, more maintainable code while providing clear interfaces that are self-documenting and automatically testable.

### **The Future of Contract Programming in Chromium**

As Chromium continues to evolve, contract programming will become even more central to its architecture:

- **Enhanced Compile-Time Validation**: Future C++ standards will enable even more sophisticated compile-time contract validation
- **Cross-Process Security**: Expanding Mojo contract patterns will provide stronger guarantees for service isolation
- **Performance Optimization**: Advanced contract-based optimizations will further improve Core Web Vitals and user experience
- **Privacy Innovation**: Contract programming will enable new privacy-preserving technologies while maintaining security guarantees

### **Best Practices for Implementation**

1. **Design Contracts First**: Define preconditions, postconditions, and error contracts before implementation
2. **Use Modern C++ Features**: Leverage `base::expected`, concepts, and RAII for robust contract enforcement
3. **Test Contract Violations**: Comprehensive testing of contract violations ensures robust error handling
4. **Monitor in Production**: Real-time contract monitoring enables proactive performance and security optimization
5. **Document Contract Guarantees**: Clear documentation of contract expectations enables safe code evolution

**Contract programming in modern Chromium demonstrates how formal software engineering principles can be applied at massive scale to create software that is simultaneously secure, performant, and maintainable. By defining clear expectations, validating assumptions, and handling errors gracefully, contract programming enables Chromium to continue pushing the boundaries of what''s possible in browser technology while maintaining the reliability and security that billions of users depend on daily.**

---

**Related Documentation:**
- [Modern C++ Patterns in Chromium](../cpp-patterns.md)
- [Mojo IPC Architecture](../../ipc-internals.md)
- [Security Model and Site Isolation](../../../security/security-model.md)
- [Performance Optimization Patterns](../../performance-patterns.md)', NULL, N'architecture', N'architecture/design-patterns/pre-post-contract', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Security Model Overview', N'# Security Model

Chromium’s security architecture is layered to protect users from malicious content, compromised sites, and browser vulnerabilities. This article breaks down the key pieces of that model—from sandboxing to origin isolation to transport security—and points you to the source files where each is implemented.

---

## 1. Threat Model & Goals

- **Threats Addressed**  
  - Arbitrary code execution via renderer or plugin bugs  
  - Cross-site data leakage (XSS, CSRF)  
  - Network eavesdropping or man-in-the-middle attacks  
- **Security Goals**  
  1. **Isolation**: ensure that untrusted web content cannot read or write user data outside its scope.  
  2. **Least Privilege**: run each component with minimal OS privileges.  
  3. **Defense in Depth**: multiple overlapping safeguards (sandbox, site isolation, CSP).  

---

## 2. Origin & Same-Origin Policy

- **Origin Definition**  
  - A tuple of (scheme, host, port). Two pages may interact only if all three match.  
- **Enforcement**  
  - Implemented in Blink’s DOM bindings under `third_party/blink/renderer/bindings/`.  
  - Checked in navigation, XHR/fetch, iframe embedding, `document.cookie`.  
- **Key Files**  
  - `security_origin.cc` (defines `SecurityOrigin` and policy checks)  
  - `script_security.cc` (enforces JS‐level checks)

---

## 3. Site Isolation & Process-Per-Site

- **Site-Per-Process**  
  - By default, Chromium maps each “site” (origin) into its own renderer process.  
  - Prevents a compromised renderer from poking into other sites’ memory.  
- **Implementation**  
  - Controlled by GN flag `site_per_process` in `content/browser/site_isolation/`.  
  - `SiteIsolationPolicy` and `SiteInstance` classes coordinate process mapping.  
- **Crash Containment**  
  - Renderer crash shows only that tab’s error page; other tabs unaffected.

---

## 4. OS-Level Sandboxing

Chromium runs its renderers and helper processes in strict OS sandboxes:

| Platform | Mechanism                                          | Source Location                           |
|----------|----------------------------------------------------|-------------------------------------------|
| **Windows** | Job objects + restricted tokens                 | `sandbox/win/`                            |
| **Linux**   | setuid “chrome-sandbox” or seccomp‐bpf filters  | `sandbox/linux/`                          |
| **macOS**   | Seatbelt profiles                                | `sandbox/mac/`                            |

- **Sandbox Brokers**  
  - A minimal “broker” process handles syscalls (e.g. DNS, font enumeration) on behalf of the sandboxed child.  
- **Key Files**  
  - `sandbox_init.cc`  
  - Platform‐specific policy headers under `sandbox/{win,linux,mac}/`.

---

## 5. Permissions & Feature Policy

- **Permissions API**  
  - JS interfaces for `geolocation`, `notifications`, `camera`, etc.  
  - Backed by `PermissionController` in `content/browser/permissions/`.  
- **Feature Policy / Permissions Policy**  
  - Page‐level opt-in/opt-out controls which APIs iframes can use.  
  - Defined via `FeaturePolicy` in Blink (`third_party/blink/renderer/core/feature_policy/`).  
- **UI Prompt**  
  - Browser UI for granting/denying lives in `chrome/browser/ui/permission_bubble/`.

---

## 6. Content Security Policy (CSP)

- **CSP Headers**  
  - Enforced by Blink’s `CSPContext` in `third_party/blink/renderer/core/loader/`.  
  - Prevents inline script, remote code, or framing per site’s policy.  
- **Reporting**  
  - Violation reports sent via `ReportSender` to configured endpoints.  

---

## 7. Transport Security & Certificate Validation

- **Trust Store**  
  - Uses OS‐provided roots on Windows/macOS; Mozilla’s on Linux.  
  - Managed in `net/cert/` (`cert_verifier.cc`, `root_store.cc`).  
- **HSTS / HPKP**  
  - HSTS enforced by `TransportSecurityState`.  
  - HPKP deprecated but still present in some code paths.  
- **OCSP & CRL Sets**  
  - Stapled OCSP responses validated in `net/ocsp/`.  
  - Chrome uses “CRLSet” updates via Safe Browsing service.

---

## 8. Safe Browsing & Malware Protection

- **Phishing & Malware Lists**  
  - Maintained by Google; downloaded to browser periodically.  
  - Checks happen in `safe_browsing/` under `chrome/browser/`.  
- **Interstitial UI**  
  - Block pages with clear warnings.  
  - Code in `chrome/browser/safe_browsing/`.  

---

## 9. Extension Security

- **Isolated Worlds**  
  - Content scripts run in separate V8 contexts with limited DOM access.  
- **Permission Model**  
  - Declared in `manifest.json`, enforced by `ExtensionPermission` classes.  
- **Native Messaging**  
  - Host apps communicate via a JSON‐over‐stdin bridge with strict path restrictions.

---

## 10. Developer Tools & Auditing

- **chrome://security** (future) and `chrome://sandbox` pages  
- **chrome://webrtc-internals** for inspecting WebRTC security parameters  
- **Auditing Tools**  
  - `chrome://policy` for Enterprise policy enforcement  
  - Tracing categories: `SECURITY`, `NETWORK_SECURITY` in `chrome://tracing`

---

## 11. Testing & Hardening

- **Unit & Integration Tests**  
  - `content/browser/site_isolation_browsertest`  
  - `security_interstitial_browsertest`  
  - `sandbox_browsertest`  
- **Fuzzing**  
  - OSS-Fuzz integration for renderer, V8, PDFium, libogg, etc.  

---

## 12. Next Steps

1. Read **Debugging → Debugging Tools** to learn how to trace sandbox violations.  
2. Explore **Modules → Networking (HTTP)** for TLS handshake internals.  
3. Dive into **Architecture → Process Model** to see how sandboxed processes communicate.  

---
', NULL, N'security', N'security/security-model', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Sandbox Architecture', N'# Sandbox Architecture in Chromium v134+

Modern Chromium''s sandbox architecture represents one of the most sophisticated security systems in contemporary software engineering. The v134+ sandbox provides comprehensive isolation through multiple defense layers, process-based security boundaries, and platform-specific mitigations that protect against both known and emerging threats.

---

## 1. Modern Sandbox Architecture Overview (v134+)

### Core Security Principles

1. **Defense in Depth**: Multiple independent security layers that fail safely
2. **Principle of Least Privilege**: Processes receive minimal necessary permissions
3. **Process Isolation**: Strong boundaries between browser components
4. **Capability-Based Security**: Explicit permission grants for specific operations
5. **Zero-Trust Architecture**: Assume all untrusted code is potentially malicious

### Multi-Layered Security Model

```text
┌─────────────────────────────────────────────────────────────┐
│                    Browser Process (Privileged)             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │   UI Process    │  │ Network Service │  │ GPU Process │ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
└─────────────────────────────┬───────────────────────────────┘
                              │ Mojo IPC (Capability-Based)
┌─────────────────────────────┴───────────────────────────────┐
│                 Sandboxed Processes (Restricted)            │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │ Renderer Process│  │ Utility Process │  │ Plugin Host │ │
│  │  (Site Isolated)│  │   (Sandboxed)   │  │ (Deprecated)│ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Modern Sandbox Components (v134+)

- **Multi-Process Architecture**: Process-per-site isolation with security boundaries
- **Mojo IPC System**: Type-safe, capability-based inter-process communication
- **Site Isolation**: Per-origin process boundaries for enhanced security
- **Control Flow Integrity (CFI)**: Hardware-assisted exploit mitigation
- **Privacy Sandbox Integration**: Isolated execution contexts for privacy features
- **Advanced Mitigations**: Platform-specific exploit prevention mechanisms

---

## 2. Cross-Platform Sandbox Implementation

### Windows Sandbox (v134+)

#### Core Windows Security Mechanisms

```cpp
// Modern Windows sandbox configuration
namespace sandbox {

class WindowsSandboxPolicy {
 public:
  // Enhanced token restrictions for v134+
  enum class TokenLevel {
    kRestrictedToken = 0,           // Highly restricted, minimal SIDs
    kLockDownToken,                 // Maximum restrictions, site isolation
    kInteractiveToken,              // Limited UI interactions
    kUnrestrictedToken              // Full user privileges (browser process)
  };
  
  // Job object restrictions with modern mitigations
  enum class JobLevel {
    kLockdown = 0,                  // Maximum restrictions
    kLimitedUser,                   // Standard renderer restrictions  
    kInteractive,                   // UI process level
    kUnprotected                    // No job restrictions
  };
  
  // Integrity levels for mandatory access control
  enum class IntegrityLevel {
    kLow = 0,                       // Sandboxed processes
    kMedium,                        // Standard user processes
    kHigh,                          // Elevated processes
    kSystem                         // System-level access
  };

  // Modern policy configuration
  base::expected<void, SandboxError> ConfigurePolicy() {
    // Set restrictive token with minimal privileges
    if (auto result = SetTokenLevel(TokenLevel::kLockDownToken); !result.has_value()) {
      return result;
    }
    
    // Configure job object with enhanced restrictions
    SetJobLevel(JobLevel::kLockdown);
    
    // Apply low integrity level for mandatory access control
    SetIntegrityLevel(IntegrityLevel::kLow);
    
    // Enable modern Windows mitigations
    EnableProcessMitigations();
    
    return base::ok();
  }

 private:
  void EnableProcessMitigations() {
    // Control Flow Integrity (CFI)
    EnableControlFlowGuard();
    
    // Return Flow Guard (RFG)
    EnableReturnFlowGuard();
    
    // Arbitrary Code Guard (ACG)
    EnableArbitraryCodeGuard();
    
    // Hardware Stack Protection (Intel CET)
    EnableHardwareStackProtection();
    
    // Process creation restrictions
    RestrictChildProcessCreation();
  }
};

}  // namespace sandbox
```

#### Windows-Specific Mitigations

**Advanced Exploit Mitigations**:
- **Control Flow Integrity (CFI)**: Hardware-assisted ROP/JOP prevention
- **Return Flow Guard (RFG)**: Return address validation
- **Arbitrary Code Guard (ACG)**: Dynamic code prevention
- **Hardware Enforcement**: Intel CET and ARM Pointer Authentication support

**Process Isolation Enhancements**:
- **Win32k Lockdown**: Kernel attack surface reduction
- **Low-Box Tokens**: AppContainer isolation with capability restrictions
- **Image Load Restrictions**: Preventing malicious DLL injection
- **Font Loading Restrictions**: Reducing GDI attack surface

### Linux Sandbox (v134+)

#### Modern Linux Security Architecture

```cpp
// Linux sandbox implementation with advanced features
namespace sandbox {

class LinuxSandboxPolicy {
 public:
  // Comprehensive Linux sandbox setup
  base::expected<void, SandboxError> Initialize() {
    // Set up namespace isolation
    if (auto result = SetupNamespaces(); !result.has_value()) {
      return result;
    }
    
    // Configure seccomp-bpf filters
    if (auto result = ApplySeccompFilters(); !result.has_value()) {
      return result;
    }
    
    // Apply LSM (SELinux/AppArmor) policies
    if (auto result = ConfigureLSM(); !result.has_value()) {
      return result;
    }
    
    // Enable modern mitigations
    EnableLinuxMitigations();
    
    return base::ok();
  }

 private:
  base::expected<void, SandboxError> SetupNamespaces() {
    // PID namespace for process isolation
    CreateNamespace(CLONE_NEWPID);
    
    // Network namespace for network isolation
    CreateNamespace(CLONE_NEWNET);
    
    // Mount namespace for filesystem isolation
    CreateNamespace(CLONE_NEWNS);
    
    // User namespace for privilege separation
    CreateNamespace(CLONE_NEWUSER);
    
    // IPC namespace for System V IPC isolation
    CreateNamespace(CLONE_NEWIPC);
    
    return base::ok();
  }
  
  base::expected<void, SandboxError> ApplySeccompFilters() {
    // Create comprehensive syscall filter
    SyscallFilter filter;
    
    // Allow essential syscalls
    filter.Allow(SYS_read);
    filter.Allow(SYS_write);
    filter.Allow(SYS_mmap);
    filter.Allow(SYS_munmap);
    
    // Block dangerous syscalls
    filter.Block(SYS_execve);
    filter.Block(SYS_ptrace);
    filter.Block(SYS_setuid);
    filter.Block(SYS_setgid);
    
    // Apply conditional rules for IPC
    filter.AllowIf(SYS_sendmsg, IsValidMojoIPC);
    filter.AllowIf(SYS_recvmsg, IsValidMojoIPC);
    
    return filter.Apply();
  }
  
  void EnableLinuxMitigations() {
    // Stack canaries and FORTIFY_SOURCE
    EnableStackProtection();
    
    // ASLR with enhanced entropy
    EnableAddressSpaceRandomization();
    
    // Control Flow Integrity (if supported)
    EnableControlFlowIntegrity();
    
    // Memory tagging (ARM64 MTE)
    EnableMemoryTagging();
  }
};

}  // namespace sandbox
```

#### Linux Security Features

**Namespace Isolation**:
- **PID Namespaces**: Process tree isolation
- **Network Namespaces**: Network stack isolation  
- **Mount Namespaces**: Filesystem view isolation
- **User Namespaces**: UID/GID mapping and privilege isolation

**Seccomp-BPF Filtering**:
- **Fine-grained Syscall Control**: Allowlist-based syscall filtering
- **Dynamic Policy Updates**: Runtime policy modifications for different phases
- **Performance Optimization**: BPF JIT compilation for filter efficiency

**Linux Security Modules (LSM)**:
- **SELinux Integration**: Mandatory Access Control with type enforcement
- **AppArmor Support**: Path-based access control
- **Custom Policies**: Chromium-specific security policies

### macOS Sandbox (v134+)

#### Advanced macOS Security Integration

```cpp
// macOS sandbox with modern security features
namespace sandbox {

class MacOSSandboxPolicy {
 public:
  base::expected<void, SandboxError> ConfigureMacOSSandbox() {
    // Apply App Sandbox with minimal entitlements
    if (auto result = ApplyAppSandbox(); !result.has_value()) {
      return result;
    }
    
    // Configure System Integrity Protection (SIP) awareness
    ConfigureSIPCompliance();
    
    // Apply Hardened Runtime features
    EnableHardenedRuntime();
    
    // Configure Gatekeeper compatibility
    ConfigureGatekeeper();
    
    return base::ok();
  }

 private:
  base::expected<void, SandboxError> ApplyAppSandbox() {
    // Minimal sandbox profile for renderer processes
    const char* sandbox_profile = R"(
      (version 7)
      (deny default)
      
      ; Allow basic system operations
      (allow process-exec (literal "/usr/lib/dyld"))
      (allow file-read* (literal "/System/Library/Frameworks"))
      (allow file-read* (literal "/usr/lib"))
      
      ; Mojo IPC permissions
      (allow mach-lookup (global-name "org.chromium.Chromium.mojo.*"))
      (allow file-read* file-write* (regex #"^/tmp/\.org\.chromium\.Chromium\."))
      
      ; Deny dangerous operations
      (deny process-fork)
      (deny process-exec)
      (deny network-outbound)
      (deny file-write* (regex #"^/"))
    )";
    
    return ApplySandboxProfile(sandbox_profile);
  }
  
  void EnableHardenedRuntime() {
    // Disable dangerous features
    DisableExecutableMemory();
    DisableDynamicCodeSigning();
    DisableJITCompilation();
    
    // Enable security features
    EnableLibraryValidation();
    EnableSystemIntegrityProtection();
  }
};

}  // namespace sandbox
```

#### macOS Security Features

**App Sandbox**:
- **Containerization**: Application-level isolation with minimal entitlements
- **Resource Access Control**: File system and network access restrictions
- **IPC Restrictions**: Limited inter-process communication capabilities

**Hardened Runtime**:
- **Code Signing Enforcement**: Strict validation of all loaded code
- **JIT Restrictions**: Just-in-time compilation limitations
- **Memory Protection**: Enhanced memory layout randomization

**System Integration**:
- **System Integrity Protection (SIP)**: System file and process protection
- **Gatekeeper**: Code signing and notarization requirements
- **XProtect**: Built-in malware detection integration

---

## 3. Site Isolation and Process Security

### Site Isolation Architecture (v134+)

```cpp
// Modern site isolation with enhanced security
namespace content {

class SiteIsolationPolicy {
 public:
  // Enhanced site isolation for v134+
  enum class IsolationLevel {
    kStrictSiteIsolation,           // Per-origin process isolation
    kPartialSiteIsolation,          // High-value site isolation  
    kProcessPerSiteInstance,        // Traditional site isolation
    kSingleProcess                  // Debugging only (insecure)
  };

  // Configure site isolation based on security requirements
  static void ConfigureIsolation(IsolationLevel level) {
    switch (level) {
      case IsolationLevel::kStrictSiteIsolation:
        EnableStrictSiteIsolation();
        EnableOriginAgentClusterIsolation();
        EnableCrossOriginEmbedderPolicyIsolation();
        break;
        
      case IsolationLevel::kPartialSiteIsolation:
        EnableHighValueSiteIsolation();
        EnablePasswordSiteIsolation();
        break;
        
      default:
        EnableDefaultSiteIsolation();
    }
  }

 private:
  static void EnableStrictSiteIsolation() {
    // Every origin gets its own process
    SiteInstance::EnableStrictSiteIsolation();
    
    // Enhanced cross-origin read blocking (CORB)
    EnableStrictCORB();
    
    // Out-of-process iframe isolation
    EnableOOPIFIsolation();
    
    // Spectre mitigations
    EnableSpectreV1Mitigations();
    EnableSpectreV2Mitigations();
  }
};

}  // namespace content
```

### Process Security Boundaries

**Renderer Process Isolation**:
- **Per-Site Process Allocation**: Separate processes for different origins
- **Cross-Origin Read Blocking (CORB)**: Preventing cross-origin data leaks
- **Out-of-Process iframes (OOPIF)**: Iframe isolation with separate processes
- **Spectre Mitigations**: Side-channel attack prevention

**Security Policy Enforcement**:
- **Content Security Policy (CSP)**: Browser-enforced content restrictions
- **Cross-Origin Embedder Policy (COEP)**: Embedding permission control
- **Cross-Origin Opener Policy (COOP)**: Window reference isolation
- **Same-Site Cookie Enforcement**: Cross-site request forgery prevention

---

## 4. Mojo IPC Security Model

### Capability-Based IPC System

```cpp
// Modern Mojo IPC with enhanced security
namespace mojo {

// Capability-based service interface
interface SecureService {
  // Capability tokens for access control
  struct ServiceCapability {
    string capability_name;
    array<uint8> capability_token;
    uint64 expiration_time;
    array<string> allowed_origins;
  };

  // Secure method invocation with capability checking
  PerformSecureOperation(ServiceCapability capability, 
                        SecureOperationRequest request) 
      => (SecureOperationResponse response);
  
  // Capability delegation with restrictions
  DelegateCapability(ServiceCapability parent_capability,
                    CapabilityRestrictions restrictions)
      => (ServiceCapability? delegated_capability);
};

// Enhanced IPC security validation
class MojoSecurityValidator {
 public:
  // Validate capability before method invocation
  base::expected<void, SecurityError> ValidateCapability(
      const ServiceCapability& capability,
      const url::Origin& requesting_origin) {
    
    // Check capability expiration
    if (IsExpired(capability)) {
      return base::unexpected(SecurityError::kCapabilityExpired);
    }
    
    // Validate origin permissions
    if (!IsOriginAllowed(capability, requesting_origin)) {
      return base::unexpected(SecurityError::kOriginNotAllowed);
    }
    
    // Verify capability token authenticity
    if (!VerifyCapabilityToken(capability)) {
      return base::unexpected(SecurityError::kInvalidToken);
    }
    
    return base::ok();
  }

 private:
  bool VerifyCapabilityToken(const ServiceCapability& capability) {
    // Cryptographic verification of capability tokens
    return crypto::VerifySignature(capability.capability_token, 
                                  capability_signing_key_);
  }
  
  crypto::SigningKey capability_signing_key_;
};

}  // namespace mojo
```

### IPC Security Features

**Capability-Based Access Control**:
- **Explicit Permission Grants**: Services require specific capabilities
- **Token-Based Authentication**: Cryptographically secure capability tokens
- **Origin-Based Restrictions**: Fine-grained origin permission control
- **Temporal Access Control**: Time-limited capability expiration

**Message Validation and Filtering**:
- **Type-Safe Serialization**: Automatic memory safety in IPC messages
- **Message Size Limits**: Prevention of resource exhaustion attacks
- **Rate Limiting**: Throttling to prevent IPC flooding
- **Content Validation**: Schema-based message validation

---

## 5. Privacy Sandbox Security Integration

### Isolated Execution Contexts

```cpp
// Privacy Sandbox isolation with enhanced security
namespace privacy_sandbox {

class PrivacySandboxIsolation {
 public:
  // Isolated execution environment for privacy features
  struct IsolationContext {
    std::string context_id;
    url::Origin top_level_origin;
    std::vector<url::Origin> allowed_origins;
    base::TimeDelta max_execution_time;
    size_t memory_limit_bytes;
    bool network_access_allowed;
  };

  // Create isolated context for privacy computation
  base::expected<IsolationContext, PrivacyError> CreateIsolatedContext(
      const url::Origin& requesting_origin,
      PrivacySandboxFeature feature) {
    
    // Validate origin permissions for privacy feature
    if (!IsOriginAllowedForFeature(requesting_origin, feature)) {
      return base::unexpected(PrivacyError::kOriginNotAllowed);
    }
    
    IsolationContext context{
      .context_id = GenerateContextId(),
      .top_level_origin = requesting_origin,
      .allowed_origins = GetAllowedOriginsForFeature(feature),
      .max_execution_time = GetExecutionTimeLimitForFeature(feature),
      .memory_limit_bytes = GetMemoryLimitForFeature(feature),
      .network_access_allowed = IsNetworkAccessAllowedForFeature(feature)
    };
    
    return context;
  }

  // Execute privacy computation in isolated environment
  void ExecutePrivacyComputation(
      const IsolationContext& context,
      const std::string& computation_code,
      base::OnceCallback<void(PrivacyComputationResult)> callback) {
    
    // Create isolated execution environment
    auto isolated_env = CreateIsolatedV8Environment(context);
    
    // Apply resource limits
    isolated_env->SetMemoryLimit(context.memory_limit_bytes);
    isolated_env->SetExecutionTimeLimit(context.max_execution_time);
    
    // Disable dangerous APIs
    isolated_env->DisableFileSystemAccess();
    isolated_env->DisableNetworkAccess(!context.network_access_allowed);
    isolated_env->DisableCrossOriginAccess();
    
    // Execute computation with monitoring
    isolated_env->ExecuteScript(computation_code, std::move(callback));
  }
};

}  // namespace privacy_sandbox
```

### Privacy Feature Security

**Topics API Security**:
- **Interest Group Isolation**: Separate processes for interest computation
- **Differential Privacy**: Mathematical privacy guarantees
- **Cross-Site Tracking Prevention**: Strong origin isolation
- **Temporal Privacy Controls**: Interest decay and rotation

**FLEDGE/Protected Audience Security**:
- **Trusted Execution Environment**: Isolated auction computation
- **Bidding Script Isolation**: Separate contexts for ad auction logic
- **Cross-Site Data Minimization**: Limited cross-site information flow
- **Cryptographic Privacy**: Secure aggregation of auction results

---

## 6. Modern Exploit Mitigations

### Hardware-Assisted Security Features

```cpp
// Advanced exploit mitigations for v134+
namespace security {

class ExploitMitigations {
 public:
  // Enable comprehensive exploit mitigations
  static void EnableAllMitigations() {
    // Control Flow Integrity
    EnableControlFlowIntegrity();
    
    // Stack protection
    EnableStackProtection();
    
    // Memory safety features
    EnableMemorySafetyFeatures();
    
    // Hardware-specific mitigations
    EnableHardwareMitigations();
  }

 private:
  static void EnableControlFlowIntegrity() {
    // Intel CET (Control-flow Enforcement Technology)
    if (cpu_info_.has_cet_support()) {
      EnableIntelCET();
    }
    
    // ARM Pointer Authentication
    if (cpu_info_.has_pointer_auth()) {
      EnableArmPointerAuth();
    }
    
    // Software CFI for unsupported hardware
    EnableSoftwareCFI();
  }
  
  static void EnableMemorySafetyFeatures() {
    // Memory tagging (ARM64 MTE)
    if (cpu_info_.has_memory_tagging()) {
      EnableMemoryTagging();
    }
    
    // Address sanitizer integration
    #if defined(ADDRESS_SANITIZER)
    EnableAddressSanitizerIntegration();
    #endif
    
    // Hardware shadow stack
    if (cpu_info_.has_shadow_stack()) {
      EnableHardwareShadowStack();
    }
  }
  
  static void EnableHardwareMitigations() {
    // Intel MPX (Memory Protection Extensions) - deprecated but relevant
    // SMEP/SMAP kernel protections
    // Branch Target Identification (BTI) on ARM
    // Load/Store Multiple restrictions
    ConfigureHardwareProtections();
  }
};

}  // namespace security
```

### Modern Mitigation Techniques

**Control Flow Protection**:
- **Intel CET**: Hardware-enforced control flow integrity
- **ARM Pointer Authentication**: Cryptographic return address protection
- **Branch Target Identification**: Valid jump target enforcement
- **Return Address Signing**: Cryptographic stack integrity

**Memory Protection**:
- **ARM Memory Tagging (MTE)**: Hardware-assisted use-after-free detection
- **Intel MPK**: Memory protection keys for fine-grained access control
- **SMEP/SMAP**: Supervisor mode execution/access prevention
- **Enhanced ASLR**: High-entropy address space randomization

**Speculative Execution Mitigations**:
- **Spectre v1/v2 Protections**: Bounds check bypass and branch target injection
- **Microarchitectural Data Sampling (MDS)**: L1TF, ZombieLoad, RIDL mitigations
- **Store Buffer Bypass**: SWAPGS and other variant protections
- **Load Value Injection (LVI)**: Intel microcode and compiler mitigations

---

## 7. Sandbox Policy Configuration

### Dynamic Policy Management

```cpp
// Dynamic sandbox policy configuration for v134+
namespace sandbox {

class DynamicPolicyManager {
 public:
  // Policy templates for different process types
  enum class ProcessType {
    kRenderer,              // Web content renderer
    kUtility,              // Utility processes
    kGpu,                  // GPU process
    kNetwork,              // Network service
    kAudio,                // Audio service
    kStorage,              // Storage service
    kPrintCompositor,      // Print compositor
    kPrivacySandbox        // Privacy Sandbox worklet
  };

  // Configure policy based on process type and security requirements
  static std::unique_ptr<SandboxPolicy> CreatePolicy(
      ProcessType process_type,
      const SecurityRequirements& requirements) {
    
    auto policy = std::make_unique<SandboxPolicy>();
    
    switch (process_type) {
      case ProcessType::kRenderer:
        ConfigureRendererPolicy(*policy, requirements);
        break;
        
      case ProcessType::kPrivacySandbox:
        ConfigurePrivacySandboxPolicy(*policy, requirements);
        break;
        
      case ProcessType::kUtility:
        ConfigureUtilityPolicy(*policy, requirements);
        break;
        
      default:
        ConfigureDefaultPolicy(*policy, requirements);
    }
    
    // Apply platform-specific enhancements
    ApplyPlatformSpecificMitigations(*policy);
    
    return policy;
  }

 private:
  static void ConfigureRendererPolicy(SandboxPolicy& policy,
                                     const SecurityRequirements& requirements) {
    // Maximum restrictions for web content
    policy.SetTokenLevel(TokenLevel::kLockdown);
    policy.SetJobLevel(JobLevel::kLockdown);
    policy.SetIntegrityLevel(IntegrityLevel::kLow);
    
    // File system access rules
    policy.AddRule(SubSystem::kFiles, FileRule::kReadOnly,
                  L"${temp}\\chromium_renderer_*");
    
    // Network restrictions (no direct network access)
    policy.BlockNetworkAccess();
    
    // IPC permissions (only Mojo)
    policy.AllowMojoIPC();
    policy.BlockLegacyIPC();
    
    // Enhanced mitigations
    policy.EnableControlFlowIntegrity();
    policy.EnableArbitraryCodeGuard();
    policy.EnableReturnFlowGuard();
  }
  
  static void ConfigurePrivacySandboxPolicy(SandboxPolicy& policy,
                                           const SecurityRequirements& requirements) {
    // Extra-restrictive policy for privacy computations
    ConfigureRendererPolicy(policy, requirements);
    
    // Additional privacy-specific restrictions
    policy.BlockFileSystemAccess();
    policy.BlockClipboardAccess();
    policy.BlockScreenCapture();
    
    // Temporal restrictions
    policy.SetMaxExecutionTime(base::Seconds(30));
    policy.SetMemoryLimit(base::Megabytes(100));
    
    // Cryptographic isolation
    policy.EnablePrivacyIsolation();
  }
};

}  // namespace sandbox
```

### Policy Rule System

**Resource Access Control**:
- **File System Rules**: Path-based access control with pattern matching
- **Registry Rules**: Windows registry access restrictions
- **Network Rules**: Protocol and destination-based network controls
- **IPC Rules**: Inter-process communication permission management

**Dynamic Policy Updates**:
- **Runtime Policy Modification**: Safe policy updates for running processes
- **Feature-Based Policies**: Conditional rules based on enabled features
- **Origin-Specific Rules**: Per-origin customization for enhanced security
- **Experiment Integration**: A/B testing of security policy variations

---

## 8. Monitoring and Introspection

### Security Event Monitoring

```cpp
// Comprehensive security monitoring for sandbox violations
namespace security {

class SandboxMonitor {
 public:
  // Security event types for monitoring
  enum class SecurityEvent {
    kPolicyViolation,           // Sandbox policy violation attempt
    kEscapeAttempt,            // Sandbox escape attempt detected
    kUnauthorizedAccess,       // Access to restricted resource
    kSuspiciousActivity,       // Anomalous behavior detected
    kExploitMitigation,        // Exploit mitigation triggered
    kCapabilityViolation       // Mojo capability violation
  };

  // Register security event handler
  void RegisterEventHandler(
      SecurityEvent event_type,
      base::RepeatingCallback<void(const SecurityEventData&)> handler) {
    event_handlers_[event_type].push_back(std::move(handler));
  }

  // Report security events with detailed context
  void ReportSecurityEvent(SecurityEvent event_type,
                          const SecurityEventData& event_data) {
    // Log security event
    LogSecurityEvent(event_type, event_data);
    
    // Update security metrics
    UpdateSecurityMetrics(event_type);
    
    // Notify registered handlers
    NotifyEventHandlers(event_type, event_data);
    
    // Take automatic response actions
    TakeSecurityResponse(event_type, event_data);
  }

 private:
  void TakeSecurityResponse(SecurityEvent event_type,
                           const SecurityEventData& event_data) {
    switch (event_type) {
      case SecurityEvent::kEscapeAttempt:
        // Immediate process termination
        TerminateCompromisedProcess(event_data.process_id);
        break;
        
      case SecurityEvent::kPolicyViolation:
        // Enhanced monitoring for process
        EnableEnhancedMonitoring(event_data.process_id);
        break;
        
      case SecurityEvent::kExploitMitigation:
        // Report to security team
        ReportToSecurityTeam(event_data);
        break;
    }
  }
  
  std::map<SecurityEvent, std::vector<base::RepeatingCallback<void(const SecurityEventData&)>>> 
      event_handlers_;
};

}  // namespace security
```

### Debugging and Analysis Tools

**Chrome Internals Integration**:
- **chrome://sandbox/**: Real-time sandbox status and policy information
- **chrome://process-internals/**: Process isolation and security boundary analysis
- **chrome://security-state/**: Comprehensive security feature status
- **chrome://policy-internals/**: Dynamic policy rule inspection

**Advanced Debugging Features**:
- **Sandbox Violation Logging**: Detailed logging of policy violations
- **Performance Impact Analysis**: Security overhead measurement
- **Security Metrics Dashboard**: Real-time security health monitoring
- **Exploit Detection Telemetry**: Automatic exploit attempt reporting

---

## 9. Performance and Security Trade-offs

### Optimized Security Implementation

```cpp
// Performance-optimized security checks
namespace security {

class OptimizedSecurityChecker {
 public:
  // Fast-path security validation for common operations
  bool FastPathSecurityCheck(const SecurityOperation& operation) {
    // Cache frequently-used security decisions
    if (auto cached_result = security_cache_.Get(operation.GetCacheKey())) {
      return *cached_result;
    }
    
    // Optimized validation for common patterns
    bool result = PerformOptimizedValidation(operation);
    
    // Cache result for future use
    security_cache_.Put(operation.GetCacheKey(), result);
    
    return result;
  }

 private:
  // Optimized validation strategies
  bool PerformOptimizedValidation(const SecurityOperation& operation) {
    // Use bloom filters for negative lookups
    if (blocked_operations_filter_.MightContain(operation.GetHash())) {
      return PerformFullSecurityCheck(operation);
    }
    
    // Fast approval for allowlisted operations
    if (allowed_operations_set_.contains(operation.GetPattern())) {
      return true;
    }
    
    // Fall back to full security check
    return PerformFullSecurityCheck(operation);
  }
  
  base::LRUCache<std::string, bool> security_cache_;
  base::BloomFilter<uint64_t> blocked_operations_filter_;
  base::flat_set<std::string> allowed_operations_set_;
};

}  // namespace security
```

### Security Performance Metrics

**Overhead Measurement**:
- **IPC Latency Impact**: Mojo security validation overhead
- **Process Creation Time**: Sandbox initialization performance
- **Memory Overhead**: Security metadata and isolation costs
- **CPU Usage**: Ongoing security check performance

**Optimization Strategies**:
- **Security Decision Caching**: Frequently-used validation results
- **Batch Security Operations**: Grouped validation for efficiency
- **Lazy Security Initialization**: On-demand security feature activation
- **Hardware Acceleration**: Leveraging security-specific CPU features

---

## 10. Future Security Enhancements

### Emerging Security Technologies

**WebAssembly Isolation**:
- **Memory-Safe Compilation**: Hardware-enforced memory safety
- **Capability-Based WASM**: Fine-grained permission systems
- **Cross-Language Security**: Unified security across WASM and JavaScript
- **Hardware Attestation**: Cryptographic execution environment verification

**Advanced Hardware Integration**:
- **Confidential Computing**: Intel TDX, AMD SEV integration
- **Hardware Security Modules (HSM)**: Cryptographic key protection
- **Secure Enclaves**: ARM TrustZone and Intel SGX utilization
- **Post-Quantum Cryptography**: Quantum-resistant security algorithms

**Zero-Trust Architecture Evolution**:
- **Continuous Verification**: Real-time trust assessment
- **Behavioral Analysis**: ML-based anomaly detection
- **Adaptive Security Policies**: Dynamic risk-based adjustments
- **Microservice Security**: Fine-grained service-to-service authentication

---

## 11. Security Best Practices for Developers

### Secure Development Guidelines

```cpp
// Security-first development patterns
namespace security_patterns {

// RAII-based security context management
class SecurityContext {
 public:
  SecurityContext(const SecurityPolicy& policy) 
      : policy_(policy), is_active_(true) {
    // Acquire security context
    if (!AcquireSecurityContext(policy_)) {
      is_active_ = false;
      LOG(FATAL) << "Failed to acquire security context";
    }
  }
  
  ~SecurityContext() {
    if (is_active_) {
      ReleaseSecurityContext();
    }
  }
  
  // Non-copyable, movable
  SecurityContext(const SecurityContext&) = delete;
  SecurityContext& operator=(const SecurityContext&) = delete;
  SecurityContext(SecurityContext&&) = default;
  SecurityContext& operator=(SecurityContext&&) = default;

  // Secure operation execution
  template<typename Operation>
  base::expected<typename Operation::Result, SecurityError> 
  ExecuteSecurely(Operation&& operation) {
    if (!is_active_) {
      return base::unexpected(SecurityError::kInactiveContext);
    }
    
    // Validate operation against security policy
    if (auto validation = ValidateOperation(operation); !validation.has_value()) {
      return base::unexpected(validation.error());
    }
    
    // Execute with security monitoring
    return ExecuteWithMonitoring(std::forward<Operation>(operation));
  }

 private:
  SecurityPolicy policy_;
  bool is_active_;
};

// Capability-based operation wrapper
template<typename T>
class SecureWrapper {
 public:
  explicit SecureWrapper(T&& value, const Capability& capability)
      : value_(std::forward<T>(value)), capability_(capability) {}
  
  // Access requires capability validation
  const T& Get() const {
    ValidateCapability(capability_);
    return value_;
  }
  
  T& GetMutable() {
    ValidateCapability(capability_);
    ValidateWriteAccess(capability_);
    return value_;
  }

 private:
  T value_;
  Capability capability_;
};

}  // namespace security_patterns
```

### Code Review Security Checklist

**Memory Safety**:
- ✅ Use smart pointers and RAII patterns
- ✅ Validate all input boundaries and buffer sizes
- ✅ Employ AddressSanitizer and MemorySanitizer in testing
- ✅ Avoid raw pointer arithmetic and unsafe casts

**IPC Security**:
- ✅ Use Mojo interfaces instead of legacy IPC mechanisms
- ✅ Validate all IPC message parameters thoroughly
- ✅ Implement capability-based access control
- ✅ Apply rate limiting to prevent IPC flooding

**Process Isolation**:
- ✅ Respect site isolation boundaries
- ✅ Minimize cross-process data sharing
- ✅ Use appropriate sandbox policies for process types
- ✅ Validate origin permissions for cross-process operations

---

## 12. References and Further Reading

### Core Implementation Files
- `sandbox/` - Cross-platform sandbox implementation
- `content/browser/renderer_host/render_process_host_impl.cc` - Process isolation
- `services/service_manager/` - Service isolation and security
- `chrome/browser/chrome_content_browser_client.cc` - Security policy configuration

### Architecture Documentation
- [Process Model](../process-model.md) - Multi-process architecture and isolation
- [IPC Internals](../ipc-internals.md) - Mojo IPC security mechanisms
- [Site Isolation](../site-isolation.md) - Per-origin process boundaries

### Security Documentation
- [Security Model](../../security/security-model.md) - Overall security architecture
- [Privacy Sandbox](../../privacy/privacy-sandbox.md) - Privacy feature isolation
- [Exploit Mitigations](../../security/exploit-mitigations.md) - Advanced protection mechanisms

### External Resources
- **Chromium Security Architecture**: Official security documentation
- **Platform Security Guides**: OS-specific security implementation details
- **CVE Database**: Historical vulnerability analysis and mitigations
- **Security Research Papers**: Academic research on browser security

---

The sandbox architecture in Chromium v134+ represents the state-of-the-art in browser security, providing comprehensive protection through multiple defense layers, process isolation, and modern exploit mitigations. Understanding this architecture is essential for developing secure browser features and maintaining the highest levels of user protection in the modern web environment.
', NULL, N'architecture', N'architecture/security/sandbox-architecture', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'JavaScript Engine (V8)', N'# JavaScript (V8)

Chromium embeds Google’s high-performance V8 JavaScript engine to power all script execution in web pages and browser internals. This article explores how V8 fits into Chromium’s architecture, its compilation & execution pipeline, memory management, embedding APIs, and debugging tools.

---

## 1. Role of V8 in Chromium

- **Where it lives**  
  - In the **renderer process**, under `src/third_party/v8/`  
  - Blink calls into V8 via the **V8 embedder APIs** in `content/renderer/v8_*`  
- **What it does**  
  - Parses, compiles, and executes all JavaScript on web pages  
  - Runs extension & internal scripts (e.g. DevTools, PDF viewer)  

---

## 2. V8 Engine Architecture

```text
JavaScript Source
      ↓
 LEXING / PARSING
      ↓           ↘
  AST           ↘  BYTECODE (Ignition)
      ↓              ↓
  TURBOFan IR ← OPTIMIZING COMPILER
      ↓
NATIVE MACHINE CODE
Parser & AST

parser.cc builds the Abstract Syntax Tree.

Uses “pre-parsing” to quickly skip heavy functions.

Ignition Interpreter

Bytecode generator (bytecode-generator.cc) produces compact bytecodes.

Interpreter (interpreter.cc) executes without initial machine-code compile.

Turbofan Optimizing Compiler

Hot functions are profiled, then passed through Turbofan (turbofan/)

Generates highly optimized machine code.

Deoptimization & On-Stack Replacement

If assumptions break (e.g. type change), deopt back to baseline.

3. Memory Management & Garbage Collection
Heaps & Spaces

Young Generation (Scavenge, Semi-Spaces)

Old Generation (Mark-Sweep, Mark-Compact)

Large Object Space

Incremental & Concurrent GC

Scavenges small heaps quickly

Marks & compacts old generation on background threads

Handles & LocalHandles

C++ wrappers ensuring safe pointer movement across GCs

4. V8 Embedding in Chromium
Isolates (v8::Isolate)

One per renderer process by default; isolates encapsulate heaps & contexts.

Contexts (v8::Context)

Execute code in separate global object environments (e.g. <iframe>).

Bindings & Templates

Native classes/functions exposed to JS via FunctionTemplate and ObjectTemplate.

Blink defines DOM APIs by wiring its C++ implementations to V8.

Microtasks & Promise Hooks

Chromium pumps the microtask queue between tasks to implement Promises.

5. Compilation & Startup
Snapshotting

Startup snapshot captures pre-compiled builtins & standard library for faster cold starts.

Build Flags

Controlled via GN args:

gn
Copy
Edit
v8_enable_pointer_compression = true
v8_enable_slow_dchecks = false
v8_static_rooting = true
Debug vs Release

Debug builds include extra checks, slower GC; release builds optimize for speed.

6. Debugging & Profiling
DevTools Protocol

V8 exposes the Debugger, Profiler, and Heap domains.

Connect via chrome://inspect or embed custom tools.

CPU & Memory Profiles

Capture JS call stacks, optimize hotspots in Turbofan.

Heap snapshots to find leaks.

Logging & Flags

bash
Copy
Edit
out/Default/chrome --js-flags="--trace-gc --trace-opt --prof"
External Tools

Heap Inspector, d8 shell for iterative testing.

7. Web Workers & Service Workers
Worker Contexts

Each worker spawns its own V8 isolate & event loop.

Shared ArrayBuffer & Atomics

Enables parallel JS with shared memory.

8. Compatibility & Standards
ECMAScript Versions

V8 keeps pace with ES6+ features: modules, async/await, proxies, BigInt.

WebAssembly

Integrated via wasm.cc modules; both interpreter and tier-up compilation.

9. Extending & Hooking In
Custom Builtins

Add new functions by extending V8’s builtins in src/third_party/v8/src/builtins.

Inspector API

Embed the Inspector protocol in other tools or integrations.

Flags & Experiments

Feature-flag new JS proposals before standardization.

10. Next Steps
Read Modules → Storage & Cache to see how JS resources (scripts, modules) are cached.

Explore Debugging → Debugging Tools for end-to-end JS debugging setups.

Clone and play with the d8 shell in third_party/v8/tools/d8 for hands-on experimentation.

', NULL, N'modules', N'modules/javascript-v8', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Networking & HTTP', N'# Networking (HTTP)

Chromium’s HTTP stack underpins all web communication. In this article we’ll trace an HTTP request from the browser down to the network, cover caching, QUIC, and show you where to hook in or inspect traffic.

---

## 1. Overview

- **Components**  
  - **Network Service** (`services/network/`)  
  - **URLLoader / URLRequest** abstractions  
  - **HTTP Cache** (`net/http/http_cache_*.cc`)  
  - **QUIC & HTTP/2** via `net/quic/` and `net/spdy/`  
- **Goals**  
  - Performance: multiplexing, caching, prioritization  
  - Security: TLS validation, safe headers  
  - Flexibility: pluggable protocols, proxy support

---

## 2. The Network Service

Chromium runs its network stack in a separate process by default:

```text
Browser Process  ←───Mojo───→  Network Service Process
Entrypoint: services/network/network_service.cc

IPC Interface: network_service.mojom

Manages global resources (DNS cache, socket pools, proxy config).

3. URLLoader / URLRequest Lifecycle
URLLoaderFactory

Created in the browser, sent over Mojo to Renderers.

Renderer calls CreateLoaderAndStart().

URLLoader

Implements network::mojom::URLLoader.

Wraps a URLRequest (non-Mojo) or directly uses UrlLoader on non-NetworkService builds.

URLRequest (net/url_request/url_request.cc)

Core state machine: redirect handling, auth, retries.

Delegates to HttpStreamFactory for transport.

text
Copy
Edit
Renderer → URLLoader → URLRequest → HttpNetworkTransaction → Socket
4. HTTP Transport
HttpNetworkTransaction (net/http/http_network_transaction.cc)

Serializes headers and body, parses responses.

Honors HttpRequestHeaders, HttpResponseHeaders.

Connection Pool (net/http/http_stream_factory.cc)

Reuses idle connections (keep-alive).

Categorizes by host:port, proxy, SSL.

5. HTTP/2 & QUIC
Chromium supports modern protocols for speed:

HTTP/2 (SPDY)

Multiplexed streams over a single TCP connection.

Implementation under net/spdy/.

QUIC (HTTP/3)

Runs atop UDP.

Implemented in net/quic/.

Handshake, stream abstraction, congestion control.

Enable via GN args:

gn
Copy
Edit
enable_http2=true
enable_quic=true
6. Caching Layer
Disk Cache (net/disk_cache/)

Stores responses keyed by URL, vary headers.

LRU eviction.

Memory Cache

Fast cache of small responses.

Cache API Hooks

HttpCache sits between URLRequest and HttpNetworkTransaction.

text
Copy
Edit
URLRequest → HttpCache → (hit: serve; miss: HttpNetworkTransaction)
7. Proxy & DNS Resolution
Proxy Configuration

Read from system or PAC scripts (proxy_config_service.cc).

DNS

HostResolver API with built-in DNS cache.

Async lookups via dns_client.cc.

8. Prioritization & Throttling
ResourceScheduler (net/http/resource_scheduler.cc)

Assigns priorities (e.g. script > image).

Limits max concurrent requests per host.

9. Security & Certificate Validation
CertVerifier (net/cert/cert_verifier.cc)

Validates TLS certificates, OCSP stapling.

TransportSecurityState

HSTS, HPKP policies.

Sandbox

Socket operations restricted by sandbox policy.

10. Debugging & Instrumentation
Logging

bash
Copy
Edit
out/Default/chrome --enable-logging=stderr --v=1
chrome://net-internals (legacy) or chrome://net-export

Tracing

NET_LOG category in chrome://tracing.

Unit Tests

Under net/http/ and net/tools/quic_client/.

11. Extensions & Hooks
If you want to inject custom behavior:

URLRequestJob

Create a factory via URLRequestFilter::RegisterProtocolHandler.

NetworkDelegate

Intercept headers, auth events in NetworkService.

12. Next Steps
Deep dive: Modules → Storage & Cache to see how responses are stored.

Explore Security → Security Model for TLS sandbox details.

Experiment: build with enable_quic=true and capture QUIC frames with Wireshark.', NULL, N'modules', N'modules/networking-http', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Storage Overview', N'# Storage & Cache

Efficient storage and caching are critical to Chromium’s performance and user experience. This article covers both the low-level HTTP cache and higher-level web storage APIs, how they interact, and where to look in the source for each.

---

## 1. Overview

- **Scope**  
  - **HTTP Cache**: response caching for network requests  
  - **In-Memory Cache**: fast lookup for small resources  
  - **Web Storage**: LocalStorage, SessionStorage, IndexedDB, Cache API  
  - **Quota & Storage Partitions**: per-origin isolation and limits  
- **Goals**  
  - **Performance**: avoid unnecessary network trips, disk I/O  
  - **Correctness**: respect cache validation (ETags, freshness)  
  - **Security**: isolate origin data, enforce quotas  

---

## 2. HTTP Cache (`net/disk_cache/` & `net/http/http_cache_*`)

### 2.1 Architecture

```text
Renderer        Browser        Network Service
   │               │                  │
   └─URLLoader───▶│                  │
           │      └──▶HttpCache───▶HttpNetworkTransaction──▶Socket
HttpCache sits in between URLRequest and HttpNetworkTransaction.

Disk Cache (LRU) implemented in net/disk_cache/simple/simple_entry_impl.cc.

Memory Cache keeps small objects in RAM (SimpleBackend, MemBackendImpl).

2.2 Key Files
net/http/http_cache.cc / .h

net/disk_cache/simple/simple_backend_impl.cc

net/disk_cache/backend_factory.h

2.3 Eviction & Validation
LRU eviction when size limit (default ~300 MB) is reached.

Cache-Control headers drive freshness; revalidate with ETag/Last-Modified.

Conditional Requests: 304 responses update stored entry metadata.

3. Quota & Storage Partitions
3.1 Storage Partitioning
Each BrowserContext (Profile) has one or more StoragePartitions.

Partitions isolate data by origin and by mode (e.g. default, incognito).

Defined in content/browser/storage_partition_impl.cc.

3.2 Quota Management
QuotaManager (content/browser/quota/quota_manager_impl.cc)

Tracks usage per origin.

Enforces soft/hard limits (default ~6 GB per origin on desktop).

QuotaClient interfaces for each storage type (IndexedDB, FileSystem, Cache API).

4. Web Storage APIs
4.1 LocalStorage & SessionStorage
LocalStorage stored in SQLite under Local Storage/ directory.

SessionStorage tied to single top-level browsing context.

Code lives in content/browser/dom_storage/ and content/renderer/dom_storage/.

4.2 IndexedDB
High-level object store, transactional.

Backed by LevelDB in third_party/blink/renderer/modules/indexeddb/.

Quota interactions via IndexedDBQuotaClient.

4.3 Cache API (Service Workers)
Programmatic cache of Request/Response pairs.

Implemented in service_worker/ under cache_storage/.

Uses the same DiskCache backend under the hood.

5. Interaction with Network Stack
Cache-Control Overrides

HTTP fetch in Service Workers can bypass the HTTP cache.

Stale-while-revalidate

Customizable via headers and Cache API strategies.

6. Debugging & Instrumentation
chrome://cache (legacy) or chrome://net-export for HTTP cache traces.

chrome://quota-internals shows per-origin usage and limits.

chrome://indexeddb-internals inspects IndexedDB databases.

Logging flags:

bash
Copy
Edit
out/Default/chrome --enable-logging=stderr --v=1 --log-net-log=netlog.json
7. Testing & Tools
Unit tests in net/disk_cache/ and content/browser/quota/.

net/tools/quic_client/ can test cache behavior over HTTP/3.

Use storage_browsertest (in content/test/) to automate web storage scenarios.

8. Best Practices & Extensions
Cache only what you can revalidate: avoid caching sensitive data.

Clean up on unload for SessionStorage in embedded contexts.

Custom URLRequestJob to layer additional caching logic:

cpp
Copy
Edit
URLRequestFilter::GetInstance()->AddUrlInterceptor(
    "https://example.com/", std::make_unique<MyCacheInterceptor>());
9. Next Steps
Dive into Security → Security Model to see how origin isolation is enforced.

Explore Modules → Networking (HTTP) to understand how HTTP caching hooks in.

Read Debugging → Debugging Tools for end-to-end cache debugging patterns.', NULL, N'modules', N'modules/storage-cache', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Disk Cache Design', N'# Disk Cache Design Principles

This deep-dive covers Chromium’s on-disk cache: its goals, on-disk format, key interfaces, and implementation notes.

---

## 1. Overview

The disk cache stores web-fetched resources for fast later access. Key characteristics:

- **Size Bound**  
  The cache must not grow without limit; an eviction algorithm decides when to remove old entries.
- **Crash Resilience**  
  Survives application crashes by discarding only entries in use at crash time. A full system crash may still wipe the entire cache.
- **Efficient Access**  
  Supports both synchronous and asynchronous operations with low latency.
- **Conflict Avoidance**  
  Layout prevents simultaneous-store conflicts (cache thrashing).
- **Entry Removal**  
  Individual entries can be removed; existing handles continue to function, and new opens fail as if the entry never existed.
- **Single-threaded Assumption**  
  Callers share one thread; callbacks are posted on the thread’s message loop to avoid reentrancy.

---

## 2. External Interfaces

Chromium’s cache API (in `src/net/disk_cache/disk_cache.h`) exposes:

- **`disk_cache::Backend`**  
  Enumerate entries, open existing or create new entries.
- **`disk_cache::Entry`**  
  Read/write data streams for a single resource.

Each entry has a unique key (e.g., `http://example.com/favicon.ico`). Data is stored in separate streams (HTTP headers vs. payload), indexed by stream ID in `Entry::ReadData`/`WriteData`.

---

## 3. On-Disk Format

All cache files live under a `cache/` directory. Chromium uses at least:

- **1 Index File**  
  Contains a memory-mapped hash table mapping keys to addresses.
- **≥4 Block-Files** (`data_n`)  
  Store fixed-size blocks (e.g., 256 B). Each file grows by 1 KB-aligned increments and chains to same-size files via headers.
- **Separate Files** (`f_xx`)  
  Resources > 16 KB bypass block-files and live in standalone files.

### 3.1 Cache Address

A 32-bit value directing to:

- A block-file (file number, start block, block count, block type)
- A separate file (hex identifier)

Defined in `disk_cache/addr.h`, it enables unified handling of diverse data.

### 3.2 Index File Structure

Defined in `disk_cache/disk_format.h`:

```text
IndexHeader
HashTable (size ≥ kIndexTableSize, actual length in header.table_len)
```

- Memory-mapped for rapid key→address lookup (using low-order hash bits).
- Header includes magic number + major/minor version; a major bump is incompatible.

### 3.3 Block-File Structure

Also in `disk_cache/disk_format.h`:

- **Header (8 KB)**: memory-mapped bitmap tracks up to ~64K blocks.
- **Data blocks**: fixed size (e.g., 256 B). Files grow by 1 024 blocks until full, then link to a new file of same block size via `next_file`.

Blocks align on 4-block boundaries to simplify allocation:

1. A record uses 1–4 contiguous blocks.  
2. Allocations jump to the next aligned region if needed.  

Header fields `empty_slots` and `hints` optimize allocation and detect crashes mid-update.

### 3.4 Cache Entry Layout

Each entry splits into two structures:

- **`EntryStore`** (1–4 blocks of 256 B)  
  Stores key hash, stream addresses, pointer to next collision, and optional out-of-line key pointer.
- **`RankingsNode`** (36 B, its own block-files)  
  Tracks eviction metadata; marked in-use while open.

### 3.5 The Big Picture

A typical cache has:

1. One index file  
2. Multiple block-files (256 B, 1 KB, 4 KB) chained by size  
3. Separate files for large payloads

Entries link across streams and files via cache addresses.  
![](../../../img/modules/the-big-picture.png)

---

## 4. Implementation Notes

### 4.1 Two Backends

- **Disk-based** (`disk_cache/backend_impl.cc`, `entry_impl.cc`)  
- **In-memory** (`disk_cache/mem_backend_impl.cc`) for Incognito mode

Cache types (media, AppCache, general) share APIs but may differ in eviction.

### 4.2 Lower-Level I/O

OS abstractions in `disk_cache/file.h` & `mapped_file.h`.  
`disk_cache::BlockFiles` manages block-file access.  
`StorageBlock<T>` template handles loading/storing of `EntryStore` or `RankingsNode`.

### 4.3 Eviction

- **Ranking lists**: `disk_cache/rankings` (and `mem_rankings`).  
- **Eviction logic**: `disk_cache/eviction` implements LRU and reuse/age-aware variants.  
- **Transactions**: ensure consistency across crashes.  
- **Multiple lists** by reuse frequency plus a “recently evicted” list.

### 4.4 Buffering

- Buffers up to 16 KB per stream before first disk write.  
- Grows to 1 MB or a global cap.  
- Minimizes disk I/O for small entries and computes record size for address allocation.

### 4.5 Deleting Entries

- `Doom*()` methods mark entries for deferred deletion after all handles close.  
- Doomed entries removed from index; new opens create fresh entries.

### 4.6 Enumeration

- Example: `URLRequestViewCacheJob` iterates entries (order not guaranteed, can be slow).

### 4.7 Sparse Data

- Supports two streams: regular + sparse.  
- Sparse data split into child entries linked from a parent (`disk_cache/sparse_control`).

### 4.8 Dedicated Cache Thread

- A background cache thread handles file I/O, offloading the browser I/O thread (IPC/UI).  
- Uses task posting (`in_flight_io` / `in_flight_backend_io`).  
- No locking: some calls (e.g. `GetDataSize`) may race with writes.

---

## 5. Data Integrity

Balancing performance vs. crash resilience:

- Leverages OS file-cache; no journaling to avoid complexity.  
- Memory-mapped headers flush latest state on crash.  
- On system crash, eviction lists may corrupt; the fallback is to discard the cache rather than risk inconsistency.

*End of Disk Cache Design Principles Deep Dive*

', NULL, N'modules', N'modules/storage-cache/disk-cache-design-principles', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'APIs & Services Overview', N'# APIs & Services Overview

Chromium''s modern architecture relies heavily on well-defined APIs and service-oriented design. This section covers the key APIs and service architecture patterns used throughout the codebase.

## What You''ll Learn

- **Mojo IPC System**: Modern inter-process communication with type safety and security
- **Service Architecture**: How Chromium''s discrete service components are organized
- **API Design Patterns**: Common patterns for building robust, maintainable APIs
- **Testing Strategies**: How to test complex service interactions and Mojo interfaces

## Key Technologies

**Mojo** is Chromium''s IPC system that enables communication between processes through strongly-typed interfaces. It provides:

- **Type Safety**: Compile-time interface validation
- **Performance**: Efficient message passing with shared memory
- **Security**: Process isolation with capability-based access
- **Cross-Platform**: Works across all supported platforms

**Services** are discrete components that communicate through Mojo interfaces, enabling better modularity, testing, and process isolation.

## Topics Covered

### Core Concepts
- [Mojo & Services](mojo_and_services) - Introduction to Chromium''s service architecture (Updated for v134+)
- [Servicification](servicification) - The process of converting legacy code to services (Updated for v134+)
- [Mojo IPC Conversion](mojo_ipc_conversion) - Migrating from legacy IPC to Mojo (Updated for v134+)

### Testing & Development
- [Mojo Testing](mojo_testing) - Testing strategies for Mojo-based services (Updated for v134+)

## Getting Started

If you''re new to Chromium''s service architecture, start with [Mojo & Services](mojo_and_services) to understand the fundamental concepts.

**Note**: All documentation in this section has been updated to reflect Chromium v134+ standards, including modern error handling patterns, security considerations, and testing approaches.

## Related Sections

- [Core Architecture](../architecture/overview) - Understanding Chromium''s overall design
- [Process Model](../architecture/process-model) - How processes are organized and isolated
- [Security Model](../security/security-model) - Security architecture and considerations
- [Testing & QA](../development/testing/testing_in_chromium) - Testing methodologies
- [Core Modules](../modules/javascript-v8) - How modules interact with services
', NULL, N'apis', N'apis/overview', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Mojo & Services', N'# Intro to Mojo &amp; Services

## Overview

This document contains the minimum amount of information needed for a developer
to start using Mojo effectively in Chromium, with example Mojo interface usage,
service definition and hookup, and a brief overview of the Content layer''s core
services.

See other [Mojo &amp; Services](/docs/README.md#Mojo-Services) documentation
for introductory guides, API references, and more.

## Mojo Terminology

A **message pipe** is a pair of **endpoints**. Each endpoint has a queue of
incoming messages, and writing a message at one endpoint effectively enqueues
that message on the other (**peer**) endpoint. Message pipes are thus
bidirectional.

A **mojom** file describes **interfaces**, which are strongly-typed collections
of **messages**. Each interface message is roughly analogous to a single proto
message, for developers who are familiar with Google protobufs.

Given a mojom interface and a message pipe, one of the endpoints
can be designated as a **`Remote`** and is used to *send* messages described by
the interface. The other endpoint can be designated as a **`Receiver`** and is used
to *receive* interface messages.

*** aside
NOTE: The above generalization is a bit oversimplified. Remember that the
message pipe is still bidirectional, and it''s possible for a mojom message to
expect a reply. Replies are sent from the `Receiver` endpoint and received by the
`Remote` endpoint.
***

The `Receiver` endpoint must be associated with (*i.e.* **bound** to) an
**implementation** of its mojom interface in order to process received messages.
A received message is dispatched as a scheduled task invoking the corresponding
interface method on the implementation object.

Another way to think about all this is simply that **a `Remote` makes
calls on a remote implementation of its interface associated with a
corresponding remote `Receiver`.**

## Example: Defining a New Frame Interface

Let''s apply this to Chrome. Suppose we want to send a "Ping" message from a
render frame to its corresponding `RenderFrameHostImpl` instance in the browser
process. We need to define a nice mojom interface for this purpose, create a
pipe to use that interface, and then plumb one end of the pipe to the right
place so the sent messages can be received and processed there. This section
goes through that process in detail.

### Defining the Interface

The first step involves creating a new `.mojom` file with an interface
definition, like so:

``` cpp
// src/example/public/mojom/pingable.mojom
module example.mojom;

interface Pingable {
  // Receives a "Ping" and responds with a random integer.
  Ping() => (int32 random);
};
```

This should have a corresponding build rule to generate C++ bindings for the
definition here:

``` python
# src/example/public/mojom/BUILD.gn
import("//mojo/public/tools/bindings/mojom.gni")
mojom("mojom") {
  sources = [ "pingable.mojom" ]
}
```

### Creating the Pipe

Now let''s create a message pipe to use this interface.

*** aside
As a general rule and as a matter of convenience when
using Mojo, the *client* of an interface (*i.e.* the `Remote` side) is
typically the party who creates a new pipe. This is convenient because the
`Remote` may be used to start sending messages immediately without waiting
for the InterfaceRequest endpoint to be transferred or bound anywhere.
***

This code would be placed somewhere in the renderer:

```cpp
// src/third_party/blink/example/public/pingable.h
mojo::Remote<example::mojom::Pingable> pingable;
mojo::PendingReceiver<example::mojom::Pingable> receiver =
    pingable.BindNewPipeAndPassReceiver();
```

In this example, ```pingable``` is the `Remote`, and ```receiver```
is a `PendingReceiver`, which is a `Receiver` precursor that will eventually
be turned into a `Receiver`. `BindNewPipeAndPassReceiver` is the most common way to create
a message pipe: it yields the `PendingReceiver` as the return
value.

*** aside
NOTE: A `PendingReceiver` doesn''t actually **do** anything. It is an
inert holder of a single message pipe endpoint. It exists only to make its
endpoint more strongly-typed at compile-time, indicating that the endpoint
expects to be bound by a `Receiver` of the same interface type.
***

### Sending a Message

Finally, we can call the `Ping()` method on our `Remote` to send a message:

```cpp
// src/third_party/blink/example/public/pingable.h
pingable->Ping(base::BindOnce(&OnPong));
```

*** aside
**IMPORTANT:** If we want to receive the response, we must keep the
`pingable` object alive until `OnPong` is invoked. After all,
`pingable` *owns* its message pipe endpoint. If it''s destroyed then so is
the endpoint, and there will be nothing to receive the response message.
***

We''re almost done! Of course, if everything were this easy, this document
wouldn''t need to exist. We''ve taken the hard problem of sending a message from
a renderer process to the browser process, and transformed it into a problem
where we just need to take the `receiver` object from above and pass it to the
browser process somehow where it can be turned into a `Receiver` that dispatches
its received messages.

### Sending a `PendingReceiver` to the Browser

It''s worth noting that `PendingReceiver`s (and message pipe endpoints in general)
are just another type of object that can be freely sent over mojom messages.
The most common way to get a `PendingReceiver` somewhere is to pass it as a
method argument on some other already-connected interface.

One such interface which we always have connected between a renderer''s
`RenderFrameImpl` and its corresponding `RenderFrameHostImpl` in the browser
is
[`BrowserInterfaceBroker`](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/public/mojom/browser_interface_broker.mojom).
This interface is a factory for acquiring other interfaces. Its `GetInterface`
method takes a `GenericPendingReceiver`, which allows passing arbitrary
interface receivers.

``` cpp
interface BrowserInterfaceBroker {
  GetInterface(mojo_base.mojom.GenericPendingReceiver receiver);
}
```
Since `GenericPendingReceiver` can be implicitly constructed from any specific
`PendingReceiver`, it can call this method with the `receiver` object it created
earlier via `BindNewPipeAndPassReceiver`:

``` cpp
RenderFrame* my_frame = GetMyFrame();
my_frame->GetBrowserInterfaceBroker().GetInterface(std::move(receiver));
```

This will transfer the `PendingReceiver` endpoint to the browser process
where it will be received by the corresponding `BrowserInterfaceBroker`
implementation. More on that below.

### Implementing the Interface

Finally, we need a browser-side implementation of our `Pingable` interface.

```cpp
#include "example/public/mojom/pingable.mojom.h"

class PingableImpl : example::mojom::Pingable {
 public:
  explicit PingableImpl(mojo::PendingReceiver<example::mojom::Pingable> receiver)
      : receiver_(this, std::move(receiver)) {}
  PingableImpl(const PingableImpl&) = delete;
  PingableImpl& operator=(const PingableImpl&) = delete;

  // example::mojom::Pingable:
  void Ping(PingCallback callback) override {
    // Respond with a random 4, chosen by fair dice roll.
    std::move(callback).Run(4);
  }

 private:
  mojo::Receiver<example::mojom::Pingable> receiver_;
};
```

`RenderFrameHostImpl` owns an implementation of `BrowserInterfaceBroker`.
When this implementation receives a `GetInterface` method call, it calls
the handler previously registered for this specific interface.

``` cpp
// render_frame_host_impl.h
class RenderFrameHostImpl
  ...
  void GetPingable(mojo::PendingReceiver<example::mojom::Pingable> receiver);
  ...
 private:
  ...
  std::unique_ptr<PingableImpl> pingable_;
  ...
};

// render_frame_host_impl.cc
void RenderFrameHostImpl::GetPingable(
    mojo::PendingReceiver<example::mojom::Pingable> receiver) {
  pingable_ = std::make_unique<PingableImpl>(std::move(receiver));
}

// browser_interface_binders.cc
void PopulateFrameBinders(RenderFrameHostImpl* host,
                          mojo::BinderMap* map) {
...
  // Register the handler for Pingable.
  map->Add<example::mojom::Pingable>(base::BindRepeating(
    &RenderFrameHostImpl::GetPingable, base::Unretained(host)));
}
```

And we''re done. This setup is sufficient to plumb a new interface connection
between a renderer frame and its browser-side host object!

Assuming we kept our `pingable` object alive in the renderer long enough,
we would eventually see its `OnPong` callback invoked with the totally random
value of `4`, as defined by the browser-side implementation above.

## Modern Mojo Patterns (Chromium v134+)

### Interface Registry Updates

Starting with Chromium v134, the recommended pattern for registering interfaces
has been streamlined. The `mojo::BinderMap` now supports more type-safe registration:

```cpp
// Modern registration pattern
void PopulateFrameBinders(RenderFrameHostImpl* host,
                          mojo::BinderMap* map) {
  // Use base::BindRepeating with proper lifetime management
  map->Add<example::mojom::Pingable>(
      base::BindRepeating(&RenderFrameHostImpl::GetPingable,
                          host->GetWeakPtr()));
}
```

### Improved Error Handling

Modern Mojo usage includes better error handling patterns:

```cpp
// Set disconnect handler for better error handling
pingable.set_disconnect_handler(base::BindOnce([]() {
  LOG(ERROR) << "Pingable service disconnected";
}));

// Use connection error callback with additional context
pingable.set_disconnect_with_reason_handler(base::BindOnce(
    [](uint32_t error_code, const std::string& description) {
      LOG(ERROR) << "Connection lost: " << error_code << " - " << description;
    }));
```

### Task Runner Specification

When binding interfaces that need specific threading behavior, explicitly specify
the task runner:

```cpp
// Bind interface to specific sequence
map->Add<magic::mojom::GoatTeleporter>(
    base::BindRepeating(&RenderFrameHostImpl::GetGoatTeleporter,
                        base::Unretained(host)),
    content::GetIOThreadTaskRunner({}));

// For UI thread binding (default, but explicit is better)
map->Add<magic::mojom::GoatTeleporter>(
    base::BindRepeating(&RenderFrameHostImpl::GetGoatTeleporter,
                        base::Unretained(host)),
    content::GetUIThreadTaskRunner({}));
```

## Services Overview &amp; Terminology
The previous section only scratches the surface of how Mojo IPC is used in
Chromium. While renderer-to-browser messaging is simple and possibly the most
prevalent usage by sheer code volume, we are incrementally decomposing the
codebase into a set of services with a bit more granularity than the traditional
Content browser/renderer/gpu/utility process split.

A **service** is a self-contained library of code which implements one or more
related features or behaviors and whose interaction with outside code is done
*exclusively* through Mojo interface connections, typically brokered by the
browser process.

Each service defines and implements a main Mojo interface which can be used
by the browser to manage an instance of the service.

## Example: Building a Simple Out-of-Process Service

There are multiple steps typically involved to get a new service up and running
in Chromium:

- Define the main service interface and implementation
- Hook up the implementation in out-of-process code
- Write some browser logic to launch a service process

This section walks through these steps with some brief explanations. For more
thorough documentation of the concepts and APIs used herein, see the
[Mojo](/mojo/README.md) documentation.

### Defining the Service

Typically service definitions are placed in a `services` directory, either at
the top level of the tree or within some subdirectory. In this example, we''ll
define a new service for use by Chrome specifically, so we''ll define it within
`//chrome/services`.

We can create the following files. First some mojoms:

``` cpp
// src/chrome/services/math/public/mojom/math_service.mojom
module math.mojom;

interface MathService {
  Divide(int32 dividend, int32 divisor) => (int32 quotient);
};
```

``` python
# src/chrome/services/math/public/mojom/BUILD.gn
import("//mojo/public/tools/bindings/mojom.gni")

mojom("mojom") {
  sources = [
    "math_service.mojom",
  ]
}
```

Then the actual `MathService` implementation:

``` cpp
// src/chrome/services/math/math_service.h
#include "chrome/services/math/public/mojom/math_service.mojom.h"

namespace math {

class MathService : public mojom::MathService {
 public:
  explicit MathService(mojo::PendingReceiver<mojom::MathService> receiver);
  MathService(const MathService&) = delete;
  MathService& operator=(const MathService&) = delete;
  ~MathService() override;

 private:
  // mojom::MathService:
  void Divide(int32_t dividend,
              int32_t divisor,
              DivideCallback callback) override;

  mojo::Receiver<mojom::MathService> receiver_;
};

}  // namespace math
```

``` cpp
// src/chrome/services/math/math_service.cc
#include "chrome/services/math/math_service.h"

namespace math {

MathService::MathService(mojo::PendingReceiver<mojom::MathService> receiver)
    : receiver_(this, std::move(receiver)) {}

MathService::~MathService() = default;

void MathService::Divide(int32_t dividend,
                         int32_t divisor,
                         DivideCallback callback) {
  // Respond with the quotient!
  std::move(callback).Run(dividend / divisor);
}

}  // namespace math
```

``` python
# src/chrome/services/math/BUILD.gn

source_set("math") {
  sources = [
    "math_service.cc",
    "math_service.h",
  ]

  deps = [
    "//base",
    "//chrome/services/math/public/mojom",
  ]
}
```

Now we have a fully defined `MathService` implementation that we can make
available in- or out-of-process.

### Hooking Up the Service Implementation

For an out-of-process Chrome service, we register a factory function
in [`//chrome/utility/services.cc`](https://source.chromium.org/chromium/chromium/src/+/main:chrome/utility/services.cc).

``` cpp
auto RunMathService(mojo::PendingReceiver<math::mojom::MathService> receiver) {
  return std::make_unique<math::MathService>(std::move(receiver));
}

void RegisterMainThreadServices(mojo::ServiceFactory& services) {
  // Existing services...
  services.Add(RunFilePatcher);
  services.Add(RunUnzipper);

  // We add our own factory to this list
  services.Add(RunMathService);
  //...
```

With this done, it is now possible for the browser process to launch new
out-of-process instances of MathService.

### Launching the Service

If you''re running your service in-process, there''s really nothing interesting
left to do. You can instantiate the service implementation just like any other
object, yet you can also talk to it via a Mojo Remote as if it were
out-of-process.

To launch an out-of-process service instance after the hookup performed in the
previous section, use Content''s
[`ServiceProcessHost`](https://source.chromium.org/chromium/chromium/src/+/main:content/public/browser/service_process_host.h)
API:

``` cpp
// Modern service launch pattern with better options API
mojo::Remote<math::mojom::MathService> math_service =
    content::ServiceProcessHost::Launch<math::mojom::MathService>(
        content::ServiceProcessHost::Options()
            .WithDisplayName("Math Service")
            .WithProcessCallback(base::BindOnce([](const base::Process& process) {
              // Optional: Handle process launch completion
              LOG(INFO) << "Math service launched with PID: " << process.Pid();
            }))
            .Pass());
```

Except in the case of crashes, the launched process will live as long as
`math_service` lives. As a corollary, you can force the process to be torn
down by destroying (or resetting) `math_service`.

We can now perform an out-of-process division:

``` cpp
// NOTE: As a client, we do not have to wait for any acknowledgement or
// confirmation of a connection. We can start queueing messages immediately and
// they will be delivered as soon as the service is up and running.
math_service->Divide(
    42, 6, base::BindOnce([](int32_t quotient) { 
      LOG(INFO) << "Result: " << quotient; 
    }));
```
*** aside
NOTE: To ensure the execution of the response callback, the
`mojo::Remote<math::mojom::MathService>` object must be kept alive (see
[this section](/mojo/public/cpp/bindings/README.md#A-Note-About-Endpoint-Lifetime-and-Callbacks)
and [this note from an earlier section](#sending-a-message)).
***

### Specifying a sandbox

All services must specify a sandbox. Ideally services will run inside the
`kService` process sandbox unless they need access to operating system
resources. For services that need a custom sandbox, a new sandbox type must be
defined in consultation with security-dev@chromium.org.

The preferred way to define the sandbox for your interface is by specifying a
`[ServiceSandbox=type]` attribute on your `interface {}` in its `.mojom` file:

```cpp
import "sandbox/policy/mojom/sandbox.mojom";

[ServiceSandbox=sandbox.mojom.Sandbox.kService]
interface FakeService {
  ...
};
```

Valid values are those in
[`//sandbox/policy/mojom/sandbox.mojom`](https://source.chromium.org/chromium/chromium/src/+/main:sandbox/policy/mojom/sandbox.mojom). Note
that the sandbox is only applied if the interface is launched
out-of-process using `content::ServiceProcessHost::Launch()`.

As a last resort, dynamic or feature based mapping to an underlying platform
sandbox can be achieved but requires plumbing through ContentBrowserClient
(e.g. `ShouldSandboxNetworkService()`).

### Security Considerations (v134+)

Modern Chromium emphasizes additional security practices for Mojo interfaces:

#### Input Validation
Always validate parameters in interface implementations:

```cpp
void MathService::Divide(int32_t dividend,
                         int32_t divisor,
                         DivideCallback callback) {
  // Validate inputs to prevent security issues
  if (divisor == 0) {
    // Use mojo::ReportBadMessage for security violations
    mojo::ReportBadMessage("Division by zero attempted");
    return;
  }
  
  // Additional range checks for potential overflow
  if (abs(dividend) > INT32_MAX / 2 || abs(divisor) > INT32_MAX / 2) {
    std::move(callback).Run(0);  // Safe fallback
    return;
  }
  
  std::move(callback).Run(dividend / divisor);
}
```

#### Interface Documentation
Use structured comments for security-critical interfaces:

```cpp
// interfaces/example.mojom
interface SecuritySensitiveService {
  // Processes user authentication token.
  // |token| must be validated before use.
  // This method should only be called from trusted contexts.
  [Sync] ValidateUserToken(string token) => (bool is_valid);
};
```

## Content-Layer Services Overview

### Interface Brokers

We define an explicit mojom interface with a persistent connection
between a renderer''s frame object and the corresponding
`RenderFrameHostImpl` in the browser process.
This interface is called
[`BrowserInterfaceBroker`](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/public/mojom/browser_interface_broker.mojom)
and is fairly easy to work with: you add a new method on `RenderFrameHostImpl`:

``` cpp
void RenderFrameHostImpl::GetGoatTeleporter(
    mojo::PendingReceiver<magic::mojom::GoatTeleporter> receiver) {
  goat_teleporter_receiver_.Bind(std::move(receiver));
}
```

and register this method in `PopulateFrameBinders` function in `browser_interface_binders.cc`,
which maps specific interfaces to their handlers in respective hosts:

``` cpp
// //content/browser/browser_interface_binders.cc
void PopulateFrameBinders(RenderFrameHostImpl* host,
                          mojo::BinderMap* map) {
...
  map->Add<magic::mojom::GoatTeleporter>(base::BindRepeating(
      &RenderFrameHostImpl::GetGoatTeleporter, base::Unretained(host)));
}
```

It''s also possible to bind an interface on a different sequence by specifying a task runner:

``` cpp
// //content/browser/browser_interface_binders.cc
void PopulateFrameBinders(RenderFrameHostImpl* host,
                          mojo::BinderMap* map) {
...
  map->Add<magic::mojom::GoatTeleporter>(base::BindRepeating(
      &RenderFrameHostImpl::GetGoatTeleporter, base::Unretained(host)),
      GetIOThreadTaskRunner({}));
}
```

Workers also have `BrowserInterfaceBroker` connections between the renderer and
the corresponding remote implementation in the browser process. Adding new
worker-specific interfaces is similar to the steps detailed above for frames,
with the following differences:
 - For Dedicated Workers, add a new method to
   [`DedicatedWorkerHost`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/worker_host/dedicated_worker_host.h)
   and register it in
   [`PopulateDedicatedWorkerBinders`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/browser_interface_binders.cc)
 - For Shared Workers, add a new method to
   [`SharedWorkerHost`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/worker_host/shared_worker_host.h)
   and register it in
   [`PopulateSharedWorkerBinders`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/browser_interface_binders.cc)
 - For Service Workers, add a new method to
   [`ServiceWorkerHost`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/service_worker/service_worker_host.h)
   and register it in
   [`PopulateServiceWorkerBinders`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/browser_interface_binders.cc)

Interfaces can also be added at the process level using the
`BrowserInterfaceBroker` connection between the Blink `Platform` object in the
renderer and the corresponding `RenderProcessHost` object in the browser
process. This allows any thread (including frame and worker threads) in the
renderer to access the interface, but comes with additional overhead because
the `BrowserInterfaceBroker` implementation used must be thread-safe. To add a
new process-level interface, add a new method to `RenderProcessHostImpl` and
register it using a call to
[`AddUIThreadInterface`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/renderer_host/render_process_host_impl.h)
in
[`RenderProcessHostImpl::RegisterMojoInterfaces`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/renderer_host/render_process_host_impl.cc).
On the renderer side, use
[`Platform::GetBrowserInterfaceBroker`](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/public/platform/platform.h)
to retrieve the corresponding `BrowserInterfaceBroker` object to call
`GetInterface` on.

For binding an embedder-specific document-scoped interface, override
[`ContentBrowserClient::RegisterBrowserInterfaceBindersForFrame()`](https://source.chromium.org/chromium/chromium/src/+/main:content/public/browser/content_browser_client.h)
and add the binders to the provided map.

*** aside
NOTE: if BrowserInterfaceBroker cannot find a binder for the requested
interface, it will call `ReportNoBinderForInterface()` on the relevant
context host, which results in a `ReportBadMessage()` call on the host''s
receiver (one of the consequences is a termination of the renderer). To
avoid this crash in tests (when content_shell doesn''t bind some
Chrome-specific interfaces, but the renderer requests them anyway),
use the
[`EmptyBinderForFrame`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/browser_interface_binders.cc)
helper in `browser_interface_binders.cc`. However, it is recommended
to have the renderer and browser sides consistent if possible.
***

### Navigation-Associated Interfaces

For cases where the ordering of messages from different frames is important,
and when messages need to be ordered correctly with respect to the messages
implementing navigation, navigation-associated interfaces can be used.
Navigation-associated interfaces leverage connections from each frame to the
corresponding `RenderFrameHostImpl` object and send messages from each
connection over the same FIFO pipe that''s used for messages relating to
navigation. As a result, messages sent after a navigation are guaranteed to
arrive in the browser process after the navigation-related messages, and the
ordering of messages sent from different frames of the same document is
preserved as well.

To add a new navigation-associated interface, create a new method for
`RenderFrameHostImpl` and register it with a call to
`associated_registry_->AddInterface` in
[`RenderFrameHostImpl::SetUpMojoConnection`](https://source.chromium.org/chromium/chromium/src/+/main:content/browser/renderer_host/render_frame_host_impl.cc;l=8365;drc=a817d852ea2f2085624d64154ad847dfa3faaeb6).
From the renderer, use
[`LocalFrame::GetRemoteNavigationAssociatedInterfaces`](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/core/frame/local_frame.h;l=409;drc=19f17a30e102f811bc90a13f79e8ad39193a6403)
to get an object to call
`GetInterface` on (this call is similar to
`BrowserInterfaceBroker::GetInterface` except that it takes a
[pending associated receiver](https://chromium.googlesource.com/chromium/src/+/main/mojo/public/cpp/bindings/README.md#associated-interfaces)
instead of a pending receiver).

## Testing Mojo Interfaces (v134+)

### Unit Testing Patterns

Modern Mojo testing uses improved patterns for better reliability:

```cpp
// test_math_service.cc
class MathServiceTest : public testing::Test {
 public:
  void SetUp() override {
    math_service_ = std::make_unique<math::MathService>(
        math_service_remote_.BindNewPipeAndPassReceiver());
  }

  void TearDown() override {
    // Ensure clean shutdown
    math_service_remote_.reset();
    task_environment_.RunUntilIdle();
  }

 protected:
  base::test::TaskEnvironment task_environment_;
  mojo::Remote<math::mojom::MathService> math_service_remote_;
  std::unique_ptr<math::MathService> math_service_;
};

TEST_F(MathServiceTest, BasicDivision) {
  base::test::TestFuture<int32_t> future;
  math_service_remote_->Divide(10, 2, future.GetCallback());
  EXPECT_EQ(future.Get(), 5);
}

TEST_F(MathServiceTest, DivisionByZeroError) {
  base::test::TestFuture<int32_t> future;
  
  // Set up bad message expectation
  std::string error_message;
  mojo::SetDefaultProcessErrorHandler(base::BindLambdaForTesting(
      [&error_message](const std::string& message) {
        error_message = message;
      }));
  
  math_service_remote_->Divide(10, 0, future.GetCallback());
  task_environment_.RunUntilIdle();
  
  EXPECT_EQ(error_message, "Division by zero attempted");
}
```

## New Features in Chromium v134+

### Enhanced Service Process Management

Chromium v134 introduces improved service lifecycle management:

```cpp
// More granular process control
auto options = content::ServiceProcessHost::Options()
    .WithDisplayName("Advanced Math Service")
    .WithSandboxType(sandbox::mojom::Sandbox::kService)
    .WithProcessCallback(base::BindOnce([](const base::Process& process) {
      // Set up process monitoring, memory limits, etc.
    }))
    .WithExtraCommandLineSwitches({"--enable-special-math-mode"});

mojo::Remote<math::mojom::MathService> service =
    content::ServiceProcessHost::Launch<math::mojom::MathService>(
        std::move(options));
```

### Improved Mojo Debugging

New debugging capabilities for interface communication:

```cpp
// Enable detailed Mojo tracing (debug builds)
TRACE_EVENT_INSTANT("mojo", "MathService::Divide",
                     TRACE_EVENT_SCOPE_THREAD,
                     "dividend", dividend,
                     "divisor", divisor);

// Use connection diagnostics
if (math_service_remote_.is_bound()) {
  // Check connection health
  bool is_connected = math_service_remote_.is_connected();
  DVLOG(7) << "Service connection status: " << is_connected;
}
```

### Structured Binding Support

Modern C++ patterns are now better supported:

```cpp
// Use structured bindings with Mojo callbacks (C++17+)
auto [success, result] = future.Take();
if (success) {
  ProcessResult(result);
}
```

## Integration Testing

For testing service process hosting:

```cpp
class MathServiceIntegrationTest : public content::BrowserTestBase {
 public:
  void SetUpOnMainThread() override {
    math_service_ = content::ServiceProcessHost::Launch<math::mojom::MathService>(
        content::ServiceProcessHost::Options()
            .WithDisplayName("Test Math Service")
            .Pass());
  }

 protected:
  mojo::Remote<math::mojom::MathService> math_service_;
};
```

## Additional Support

If this document was not helpful in some way, please consider:

- Checking the [Mojo documentation](https://chromium.googlesource.com/chromium/src/+/main/mojo/README.md) for comprehensive API references
- Reviewing existing implementations in the Chromium codebase for patterns
- Posting questions to [chromium-mojo@chromium.org](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-mojo) for Mojo-specific issues
- Posting to [services-dev@chromium.org](https://groups.google.com/a/chromium.org/forum/#!forum/services-dev) for service architecture questions
- Filing bugs at [crbug.com](https://bugs.chromium.org/p/chromium/issues/list) with the `Internals>Mojo` component for suspected issues

For WanderLust-specific implementations, consult the [custom browser documentation](/docs) in this knowledge base.
', NULL, N'apis', N'apis/mojo_and_services', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Mojo IPC Conversion', N'# Converting Legacy IPC to Mojo

## Overview

A number of IPC messages sent (primarily between the browser and renderer
processes) are still defined using Chrome''s old IPC system in `//ipc`. This
system uses
[`base::Pickle`](https://source.chromium.org/chromium/chromium/src/+/main:base/pickle.h;drc=main;l=128)
as the basis for message serialization and is supported by a number of `IPC_*`
preprocessor macros defined in `//ipc` and used around the source tree.

There is an ongoing, distributed effort to get these messages converted to Mojo
interface messages. As of Chromium v134+, most critical IPC conversions have been
completed, but some legacy messages remain. Messages that still need to be converted are tracked in two
spreadsheets:

- [Chrome IPC to Mojo migration](https://docs.google.com/spreadsheets/d/1pGWX_wxGdjAVtQOmlDDfhuIc3Pbwg9FtvFXAXYu7b7c/edit#gid=0) for non-web platform messages
- [Mojoifying Platform Features](https://docs.google.com/spreadsheets/d/1VIINt17Dg2cJjPpoJ_HY3HI0uLpidql-1u8pBJtpbGk/edit#gid=1603373208) for web platform messages

**Note for v134+**: Focus should be on converting remaining high-risk or frequently-used IPC messages,
as the majority of the migration work has been completed. New features should use Mojo from the start.

This document is concerned primarily with rote conversion of legacy IPC messages
to Mojo interface messages. If you are considering more holistic refactoring and
better isolation of an entire subsystem of the browser, you may consider
[servicifying](servicification.md) the feature instead of merely converting its
IPCs.

See other [Mojo &amp; Services](mojo_and_services.md) documentation
for introductory guides, API references, and more.

## Legacy IPC Concepts

Each Content child process has a single **`IPC::Channel`** implementation going
between it and the browser process, and this is used as the sole two-way FIFO
to send legacy IPC messages between the processes.

There are two fundamental types of legacy IPC messages: **control** messages,
defined via `IPC_MESSAGE_CONTROLn` macros (where `n` is some small integer) and
**routed** messages defined via `IPC_MESSAGE_ROUTEDn` macros.

Control messages generally go between a browser-side process host (*e.g.*,
`RenderProcessHost` or `GpuProcessHost`) and the child-side `ChildThreadImpl`
subclass. All of these classes implement `IPC::Sender` and thus have a `Send`
method for sending a control message to their remote counterpart, and they
implement `IPC::Listener` to receive incoming control messages via
`OnMessageReceived`.

Routed messages are relegated to **routes** which have arbitrary meaning
determined by their use within a given process. For example, renderers use
routes to isolate messages scoped to individual render frames, and so such
routed messages will travel between a `RenderFrameHostImpl` and its
corresponding `RenderFrameImpl`, both of which also implement `IPC::Sender` and
`IPC::Listener`.

## Mojo Interfaces as Routes

Routed messages in the old IPC system always carry a **routing ID** to identify
to the receiving endpoint which routed object (*e.g.* which `RenderFrameImpl`
or `RenderViewImpl` or whatever) the message is targeting. Each endpoint is thus
required to do some additional book-keeping to track what each routing ID means.

Mojo interfaces obviate the need for routing IDs, as new "routes" can be
established by simply creating a new interface pipe and passing one endpoint to
something which knows how to bind it.

When thinking about an IPC message conversion to Mojo, it''s important to
consider whether the message is a control message or a routed message, as this
determines where you might find an existing Mojo interface to carry your
message, or where you will want to add a new end-to-end Mojo interface for that
purpose. This can mean the difference between a single per-process interface
going between each `RenderProcessHostImpl` and its corresponding
`RenderThreadImpl`, vs a per-frame interface going between each
`RenderFrameHostImpl` and its corresponding `RenderFrameImpl`.

## Ordering Considerations

One **very important** consideration when doing IPC conversions is the relative
ordering of IPC-driven operations. With the old IPC system, because every
message between two processes is globally ordered, it is quite easy for parts
of the system to (intentionally or often unintentionally) rely on strict
ordering guarantees.

For example, imagine a `WebContentsObserver` in the browser processes observes
a frame navigation and immediately sends an IPC message to the frame to
configure some new behavior. The implementation may be inadvertently relying on
this message arriving *before* some other tangentially related message sent to
the same frame shortly after the same navigation event.

While Mojo guarantees strict ordering within each message pipe, Mojo does not
(and in fact cannot) make any strict ordering guarantees between separate
message pipes, as message pipes may be freely moved across process boundaries
and thus cannot necessarily share a common FIFO at all times.

If the two messages described above were moved to separate Mojo interfaces on
separate message pipes, renderer behavior could break as the first message may
arrive after the second message.

The best solution to this problem is to rethink the IPC surface and/or
implementation on either side to eliminate ordering dependencies between two
interfaces that otherwise seem to be logically distinct. Failing that, Mojo''s
solution to this problem is to support
[**associated interfaces**](/mojo/public/tools/bindings/README.md#Associated-Interfaces).
In a nutshell, these allow multiple distinct interfaces to be multiplexed over
a shared message pipe.

## Channel-Associated Interfaces

The previous section mentions **associated interfaces** as a general-purpose
solution for establishing a mutual FIFO between multiple logical Mojo interfaces
by having them share a single message pipe.

In Chrome, the `IPC::Channel` which carries all legacy IPC messages between
two processes is itself a Mojo message pipe. We provide a mechanism for
associating arbitrary Mojo interfaces with this pipe, which means messages can
be converted to Mojo while preserving strict FIFO with respect to other legacy
IPC messages. Such interfaces are designated in Chrome parlance as
**Channel-associated interfaces**.

*** aside
**NOTE:** Channel-associated interface acquisition is not constrained by
modern security infrastructure in the same way as regular Mojo interfaces,
so security reviewers need to be especially careful to inspect
new additions and uses of such interfaces.
***

Usage of Channel-associated interfaces should be rare but is considered a
reasonable intermediate solution for incremental IPC conversions where it would
be too risky or noisy to convert a large IPC surface all at once, but it would
also be impossible to split the IPC surface between legacy IPC and a dedicated
Mojo interface pipe without introducing timing bugs.

At this point in Chrome''s development, practical usage of Channel-associated
interfaces is restricted to the `IPC::Channel` between the browser process and
a renderer process, as this is the most complex IPC surface with the most
implicit ordering dependencies. A few simple APIs exist to support this.

`RenderProcessHostImpl` owns an `IPC::Channel` to its corresponding
`RenderThreadImpl` in the render process. This object has a
`GetRemoteAssociatedInterfaces` method which can be used to pass arbitrary
associated interface requests:

``` cpp
mojo::AssociatedRemote<magic::mojom::GoatTeleporter> teleporter;
channel_->GetRemoteAssociatedInterfaces()->GetInterface(
    teleporter.BindNewEndpointAndPassReceiver());

// These messages are all guaranteed to arrive in the same order they were sent.
channel_->Send(new FooMsg_SomeLegacyIPC);
teleporter->TeleportAllGoats();
channel_->Send(new FooMsg_AnotherLegacyIPC);
```

Likewise, `ChildThreadImpl` has an `IPC::Channel` that can be used in the same
way to send such messages back to the browser.

To receive and bind incoming Channel-associated interface requests, the above
objects also implement `IPC::Listener::OnAssociatedInterfaceRequest`.

For supplementation of routed messages, both `RenderFrameHostImpl` and
`RenderFrameImpl` define a `GetRemoteAssociatedInterfaces` method which works
like the one on `IPC::Channel`, and both objects also implement
`IPC::Listener::OnAssociatedInterfaceRequest` for processing incoming associated
interface requests specific to their own frame.

There are some example conversion CLs which use Channel-associated interfaces
[here](https://codereview.chromium.org/2381493003) and
[here](https://codereview.chromium.org/2400313002).

## Modern Security Considerations (v134+)

When converting legacy IPC to Mojo in Chromium v134+, additional security considerations must be taken into account:

### Interface Broker Security

All new Mojo interfaces should be properly registered with the appropriate interface broker:
- Frame-scoped interfaces should use `RenderFrameHostImpl::GetBrowserInterfaceBroker()`
- Process-scoped interfaces should use appropriate process-level brokers
- Ensure proper capability validation and origin checks where needed

### Capability-Based Security

Modern Chromium uses capability-based security patterns:
- Interfaces should only expose the minimum required functionality
- Consider using capability delegation patterns for complex permission scenarios
- Validate all inputs at interface boundaries, not just at the call site

### Memory Safety

When converting IPC structures:
- Prefer using `base::span<>` over raw pointers and lengths
- Use `mojo::StructPtr<>` for nullable complex types
- Ensure proper bounds checking in custom serialization code

## Deciding How to Approach a Conversion

There are a few questions you should ask before embarking upon any IPC message
conversion journey, and there are many potential approaches to consider. The
right one depends on context.

Note that this section assumes the message is traveling between the browser
process and a renderer process. Other cases are rare and developers may wish to
consult
[chromium-mojo@chromium.org](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-mojo)
before proceeding with them. Otherwise, apply the following basic algorithm to
decide how to proceed:

- General note: If the message is a reply to some other message (typically these
  take a "request ID" argument), see the note about message replies at the
  bottom of this section.
- Consider whether or not the message makes sense as part of the IPC surface of
  a new or existing service somewhere in `//services` or `//chrome/services`,
  *etc.* This is less and less likely to be the case as time goes on, as many
  remaining IPC conversions are quite narrowly dealing with specific
  browser/renderer details rather than the browser''s supporting subsystems. If
  defining a new service, you may wish to consult some of the other
  [Mojo &amp; Services documentation](/docs/README.md#Mojo-Services) first.
- If the message is an `IPC_MESSAGE_CONTROL` message:
    - If there are likely to be strict ordering requirements between this
      message and other legacy IPC or Channel-associated interface messages,
      consider using a new or existing
      [Channel-associated interface](#Channel-Associated-Interfaces) between
      `RenderProcessHostImpl` and `RenderThreadImpl`.
    - If the message is sent from a renderer to the browser:
        - If an existing interface is bound by `RenderProcessHostImpl` and
          requested through `RenderThread`''s Connector and seems to be a good
          fit for the message, add the equivalent Mojo message to that
          interface.
        - If no such interface exists, consider adding one for this message and
          any related messages.
    - If the message is sent from the browser to a renderer:
        - If an existing interface is bound by `RenderThreadImpl` and requested
          through the browser''s interface broker system,
          and the interface seems to be a good fit for the message, add the
          equivalent Mojo message to that interface.
        - If no such interface exists, consider adding one for this message and
          any related messages.
- If the message is an `IPC_MESSAGE_ROUTED` message:
    - Determine what the routing endpoints are. If they are
      `RenderFrameHostImpl` and `RenderFrameImpl`:
        - If there are likely to be strict ordering requirements between this
          message and other legacy IPC or Channel-associated interface messages,
          consider using a new or existing
          [Channel-associated interface](#Channel-Associated-Interfaces) between
          `RenderFrameHostImpl` and `RenderFrameImpl`.
        - If the message is sent from a renderer to the browser:
            - If an existing interface is bound by `RenderFrameHostImpl` and
              acquired via `RenderFrame::GetBrowserInterfaceBroker` and the interface seems
              to be a good fit for this message, add the equivalent Mojo message
              to that interface.
            - If no such interface exists, consider adding one and registering it
              with `RenderFrameHostImpl`''s `BrowserInterfaceBroker`. See the
              [simple example](mojo_and_services.md#Example_Defining-a-New-Frame-Interface)
              in the "Intro to Mojo & Services" document.
        - If the message is sent from the browser to a renderer, consider
          adding a Mojo equivalent to the `content.mojom.Frame` interface
          defined in
          [frame.mojom](https://source.chromium.org/chromium/chromium/src/+/main:content/common/frame.mojom;drc=main).
    - If the routing endpoints are **not** frame objects (for example, they may
      be `RenderView`/`RenderViewHost` objects), this is a special case which
      does not yet have an easy conversion approach readily available. Contact
      [chromium-mojo@chromium.org](https://groups.google.com/a/chromium.org/forum#!forum/chromium-mojo)
      to propose or discuss options.

*** aside
**NOTE**: If you are converting a sync IPC, see the section on
[Synchronous Calls](https://chromium.googlesource.com/chromium/src/+/main/mojo/public/cpp/bindings/README.md#Synchronous-Calls)
in the Mojo documentation.
***

### Dealing With Replies

If the message is a **reply**, meaning it has a "request ID" which correlates it
to a prior message in the opposite direction, consider converting the
**request** message following the algorithm above. Unlike with legacy IPC, Mojo
messages support replies as a first-class concept. So for example if you have:

``` cpp
IPC_CONTROL_MESSAGE2(FooHostMsg_DoTheThing,
                     int /* request_id */,
                     std::string /* name */);
IPC_CONTROL_MESSAGE2(FooMsg_DidTheThing,
                     int /* request_id */,
                     bool /* success */);
```

You should consider defining an interface `Foo` which is bound in
`RenderProcessHostImpl` and acquired from `RenderThreadImpl`, with the following
mojom definition:

``` cpp
interface Foo {
  DoTheThing(string name) => (bool success);
};
```
See [Receiving responses](https://chromium.googlesource.com/chromium/src/+/main/mojo/public/cpp/bindings/README.md#receiving-responses)
for more information.

## Repurposing `IPC::ParamTraits` and `IPC_STRUCT*` Invocations

Occasionally it is useful to do partial IPC conversions, where you want to
convert a message to a Mojo interface method but you don''t want to necessarily
convert every structure passed by the message. In this case, you can leverage
Mojo''s
[type-mapping](https://chromium.googlesource.com/chromium/src/+/main/mojo/public/cpp/bindings/README.md#Type-Mapping)
system to repurpose existing `IPC::ParamTraits`.

*** aside
**NOTE**: Although in some cases `IPC::ParamTraits<T>` specializations are
defined manually in library code, the `IPC_STRUCT*` macro helpers also define
`IPC::ParamTraits<T>` specializations under the hood. All advice in this section
pertains to both kinds of definitions.
***

If a mojom struct is declared without a struct body and is tagged with
`[Native]`, and a corresponding typemap is provided for the struct, the emitted
C++ bindings will -- as if by magic -- replace the mojom type with the
typemapped C++ type and will internally use the existing `IPC::ParamTraits<T>`
specialization for that type in order to serialize and deserialize the struct.

For example, given an existing IPC struct definition like
[`resource_messages.h`](https://source.chromium.org/chromium/chromium/src/+/main:content/common/resource_messages.h;drc=main) 
which defines an IPC mapping for `content::ResourceRequest`:

``` cpp
IPC_STRUCT_TRAITS_BEGIN(content::ResourceRequest)
  IPC_STRUCT_TRAITS_MEMBER(method)
  IPC_STRUCT_TRAITS_MEMBER(url)
  // ...
IPC_STRUCT_TRAITS_END()
```

and the
[`resource_request.h`](https://source.chromium.org/chromium/chromium/src/+/main:content/common/resource_request.h;drc=main) header
which actually defines the `content::ResourceRequest` type:

``` cpp
namespace content {

struct CONTENT_EXPORT ResourceRequest {
  // ...
};

}  // namespace content
```

we can declare a corresponding "native" mojom struct:

``` cpp
module content.mojom;

[Native]
struct URLRequest;
```

and add a typemap like
[`url_request.typemap`](https://source.chromium.org/chromium/chromium/src/+/main:content/common/url_request.typemap;drc=main)
to define how to map between them:

``` python
mojom = "//content/public/common/url_loader.mojom"
public_headers = [ "//content/common/resource_request.h" ]
traits_headers = [ "//content/common/resource_messages.h" ]
...
type_mappings = [ "content.mojom.URLRequest=content::ResourceRequest" ]
```

Note specifically that public_headers includes the definition of the native C++
type, and traits_headers includes the definition of the legacy IPC traits.

As a result of all this, other mojom files can now reference
`content.mojom.URLRequest` as a type for method parameters and other struct
fields, and the generated C++ bindings will represent those values exclusively
as `content::ResourceRequest` objects.

This same basic approach can be used to leverage existing `IPC_ENUM_TRAITS` for
invocations for `[Native]` mojom enum aliases.

*** aside
**NOTE:** Use of `[Native]` mojom definitions is strictly limited to C++
bindings. If a mojom message depends on such definitions, it cannot be sent or
received by other language bindings. This feature also depends on continued
support for legacy IPC serialization and all uses of it should therefore be
treated as technical debt.
***

## Blink-Specific Advice

### Variants
Let''s assume we have a mojom file such as this:

``` cpp
module example.mojom;

interface Foo {
  SendData(string param1, array<int32> param2);
};
```

The following GN snippet will generate two concrete targets: `example` and
`example_blink`:

```
mojom("example") {
  sources = [ "example.mojom" ]
}
```

The target `example` will generate Chromium-style C++ bindings using STL types:

``` cpp
// example.mojom.h
namespace example {
namespace mojom {

class Example {
  virtual void SendArray(const std::string& param1, const std::vector<int32_t>& param2) = 0;
}

} // namespace mojom
} // namespace example
```

The target `example_blink` will generate Blink-style C++ bindings using WTF types:

``` cpp
// example.mojom-blink.h
namespace example {
namespace mojom {
namespace blink {

class Example {
  virtual void SendArray(const WTF::String& param1, const WTF::Vector<int32_t>& param2) = 0;
}

} // namespace blink
} // namespace mojom
} // namespace example
```

Thanks to these separate sets of bindings no work is necessary to convert types
between Blink-style code and Chromium-style code. It is handled automatically
during message serialization and deserialization.

For more information about variants, see
[this section](https://chromium.googlesource.com/chromium/src/+/main/mojo/public/cpp/bindings/README.md#Variants) of the C++ bindings
documentation.

### Binding callbacks

Mojo methods that return a value take an instance of `base::OnceCallback`.
Use `WTF::BindOnce()` and an appropriate wrapper function depending on the type of
object and the callback.

For garbage-collected (Oilpan) classes owning the `mojo::Remote`, it is recommended
to use `WrapWeakPersistent(this)` for connection error handlers since they
are not guaranteed to get called in a finite time period (wrapping the object
with `WrapPersistent` in this case would cause memory leaks).

If the response can be discarded in case the object is not alive by the time
the response is received, use `WrapWeakPersistent(this)` for binding the response callback:

``` cpp
// Modern example with error handling
auto remote = std::make_unique<mojo::Remote<device::mojom::SensorProvider>>();
remote->set_disconnect_handler(WTF::BindOnce(
    &DeviceSensorEntry::HandleSensorError, WrapWeakPersistent(this)));

// Use more specific error handling
remote->GetSensor(device::mojom::SensorType::ACCELEROMETER,
    WTF::BindOnce(&DeviceSensorEntry::OnSensorCreated, 
                  WrapWeakPersistent(this)));
```

Otherwise (for example, if the response callback is used to resolve a Promise),
use `WrapPersistent(this)` to keep the object alive:

``` cpp
// Promise-based example with proper error handling
ScriptPromiseResolver* resolver = MakeGarbageCollected<ScriptPromiseResolver>(script_state);
auto promise = resolver->Promise();

nfc_remote_->CancelAllWatches(
    WTF::BindOnce(&NFC::OnRequestCompleted,
                  WrapPersistent(this),
                  WrapPersistent(resolver)));
                  
return promise;
```
... 
nfc_->CancelAllWatches(WTF::BindOnce(&NFC::OnRequestCompleted,
                                 WrapPersistent(this),
                                 WrapPersistent(resolver)));
```

Non-garbage-collected objects can use `WTF::Unretained(this)` for both response
and error handler callbacks when the `mojo::Remote` is owned by the object bound
to the callback or the object is guaranteed to outlive the Mojo connection for
another reason. Otherwise a weak pointer should be used. However, it is not a
common pattern since using Oilpan is recommended for all Blink code.

### Implementing Mojo interfaces in Blink

Only a `mojo::Receiver` or `mojo::ReceiverSet` should be used when implementing a
Mojo interface in an Oilpan-managed object. The object must then have a pre-finalizer
to close any open pipes when the object is about to be swept as lazy sweeping
means that it may be invalid long before the destructor is called. This requires
setup in both the object header and implementation.

``` cpp
// MyObject.h
class MyObject : public GarbageCollected<MyObject>,
                 public example::mojom::blink::Example,
                 public Supplement<ExecutionContext> {
  USING_PRE_FINALIZER(MyObject, Dispose);
  USING_GARBAGE_COLLECTED_MIXIN(MyObject);

 public:
  static const char kSupplementName[];
  static MyObject& From(ExecutionContext&);

  explicit MyObject(ExecutionContext&);
  void Dispose();

  // Implementation of example::mojom::blink::Example.
  void DoSomething(const WTF::String& data, 
                   DoSomethingCallback callback) override;

  // Supplement implementation
  void Trace(Visitor*) const override;

 private:
  mojo::Receiver<example::mojom::blink::Example> receiver_{this};
  Member<ExecutionContext> execution_context_;
};

// MyObject.cpp
void MyObject::Dispose() {
  receiver_.reset();
}

void MyObject::Trace(Visitor* visitor) const {
  visitor->Trace(execution_context_);
  Supplement<ExecutionContext>::Trace(visitor);
}
```

For more information about Blink''s Garbage Collector, see
[Blink GC API Reference](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/platform/heap/BlinkGCAPIReference.md;drc=main).

## Testing Converted Mojo Interfaces

When converting legacy IPC to Mojo, it''s important to update tests appropriately:

### Unit Testing Patterns

Use `mojo::test::MockReceiver` and `mojo::Remote` for testing:

``` cpp
// test_helper.h
class MockExampleInterface : public example::mojom::Example {
 public:
  MockExampleInterface() = default;
  ~MockExampleInterface() override = default;

  MOCK_METHOD(void, DoSomething, 
              (const std::string& data, DoSomethingCallback callback), 
              (override));

  mojo::PendingRemote<example::mojom::Example> BindNewPipeAndPassRemote() {
    return receiver_.BindNewPipeAndPassRemote();
  }

 private:
  mojo::Receiver<example::mojom::Example> receiver_{this};
};
```

### Integration Testing

For integration tests involving converted IPC:
- Use `base::test::TaskEnvironment` for proper async handling
- Consider using `mojo::SyncCallRestrictions::ScopedAllowSyncCallForTesting` for test-only synchronous calls
- Ensure proper cleanup of Mojo connections in test teardown

### Browser Tests

When testing frame-scoped interfaces:
- Use `RenderFrameHostTester` for setting up test scenarios
- Consider using `MockBrowserInterfaceBroker` for controlled testing environments

### Typemaps For Content and Blink Types

Using typemapping for messages that go between Blink and content browser code
can sometimes be tricky due to things like dependency cycles or confusion over
the correct place for some definition to live. 

Modern approaches for v134+ include:
- Using `base::span<>` instead of raw arrays where possible
- Leveraging `std::optional<>` for nullable primitive types
- Using `base::flat_map<>` and `base::flat_set<>` for better performance

Feel free to contact
[chromium-mojo@chromium.org](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-mojo)
with specific details if you encounter trouble.

Example patterns for modern typemaps:

``` cpp
// Modern mojom definition
module example.mojom;

struct ModernRequest {
  string url;
  map<string, string> headers;
  array<uint8>? body;  // Optional body data
};

interface ModernAPI {
  ProcessRequest(ModernRequest request) => (bool success, string? error);
};
```

With corresponding typemap using modern C++ types:

``` python
mojom = "//example/public/mojom/modern_api.mojom"
public_headers = [ 
  "//example/public/modern_request.h",
  "//base/containers/flat_map.h"
]
traits_headers = [ "//example/common/modern_request_mojom_traits.h" ]
type_mappings = [ 
  "example.mojom.ModernRequest=example::ModernRequest[move_only]" 
]
```

## Additional Support

If this document was not helpful in some way, please post a message to your
friendly [chromium-mojo@chromium.org](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-mojo)
mailing list.

For Chromium v134+ specific questions:
- Check the [Mojo documentation](https://chromium.googlesource.com/chromium/src/+/main/mojo/README.md) for the latest patterns
- Review recent [Mojo-related CLs](https://chromium-review.googlesource.com/q/hashtag:mojo) for examples
- Consider the [Chromium security guidelines](https://chromium.googlesource.com/chromium/src/+/main/docs/security/README.md) for interface design

## See Also

- [Mojo & Services Overview](mojo_and_services.md)
- [Servicification Guide](servicification.md)
- [Chromium IPC Security](https://source.chromium.org/chromium/chromium/src/+/main:docs/security/mojo.md)
', NULL, N'apis', N'apis/mojo_ipc_conversion', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Servicification', N'# Servicifying Chromium Features (v134+)

## Overview

Much to the dismay of Chromium developers, practicing linguists, and keyboard
operators everywhere, the term **servicificificification** [sic] has been
egregiously smuggled into the Chromium parlance.

Lots of Chromium code is contained in reasonably well-isolated component
libraries with some occasionally fuzzy boundaries and often a surprising number
of gnarly runtime interdependencies among a complex graph of components. Y
implements one of Z''s delegate interfaces, while X implements one of Y''s
delegate interfaces, and now it''s possible for some ridiculous bug to creep in
where W calls into Z at the wrong time and causes a crash in X. Yikes.

Servicification embodies the ongoing process of **servicifying** Chromium
features and subsystems, or refactoring these collections of library code into
services with well-defined public API boundaries and very strong runtime
isolation via Mojo interfaces.

**Note for v134+**: As of Chromium v134, most major subsystems have been servicified.
New servicification efforts should focus on remaining components that would benefit
from isolation, testing improvements, or multi-process architecture flexibility.

The primary goals are to improve maintainability and extensibility of the system
over time, while also allowing for more flexible runtime configuration. For
example, with the Network Service in place we can now run the entire network
stack either inside or outside of the browser process with the flip of a
command-line switch. Client code using the Network Service stays the same,
independent of that switch.

This document focuses on helpful guidelines and patterns for servicifying parts
of Chromium.

Also see general [Mojo & Services](mojo_and_services.md)
documentation for other introductory guides, API references, *etc.*

## Setting Up The Service

This section briefly covers early decisions and implementation concerns when
introducing a new service.

### Where in the Tree?

Based on the
[service development guidelines](https://source.chromium.org/chromium/chromium/src/+/main:services/README.md;drc=main), any service which could
be reasonably justified as a core system service in a hypothetical,
well-designed operating system may belong in the top-level `//services`
directory. If that sounds super hand-wavy and unclear, that''s because it is!
There isn''t really a great universal policy here, so when in doubt, contact your
favorite local
[services-dev@chromium.org](https://groups.google.com/a/chromium.org/forum#!forum/services-dev)
mailing list and start a friendly discussion.

**Modern Guidelines (v134+)**: Consider these factors when choosing location:
- **Security isolation requirements**: High-risk code should be in separate processes
- **Resource constraints**: Services with heavy resource usage should be isolatable
- **Testing complexity**: Services are easier to test in isolation
- **API stability**: Well-defined APIs are candidates for `//services`
mailing list and start a friendly discussion.

Other common places where developers place services, and why:

- `//components/services` for services which haven''t yet made the cut for
  `//services` but which are either used by Content directly or by multiple
  Content embedders.
- `//chrome/services` for services which are used exclusively within Chrome and
  not shared with other Content embedders.
- `//chromeos/services` for services which are used on Chrome OS by more than
  just Chrome itself (for example, if the `ash` service must also connect to
  them for use in system UI).

### Launching Service Processes

Content provides a simple
[`ServiceProcessHost`](https://source.chromium.org/chromium/chromium/src/+/main:content/public/browser/service_process_host.h;drc=main)
API to launch a new Service Process. The Mojo Remote corresponding to each
process launch is effectively a lifetime control for the launched process.

**Modern Pattern (v134+)**: Use `ServiceProcessHost::Launch` with proper error handling:

```cpp
// Modern service launching pattern
auto service_remote = content::ServiceProcessHost::Launch<mojom::MyService>(
    content::ServiceProcessHost::Options()
        .WithDisplayName("My Service")
        .WithSandboxType(sandbox::mojom::Sandbox::kService)
        .Pass());

service_remote.set_disconnect_handler(
    base::BindOnce(&MyServiceClient::OnServiceDisconnected,
                   weak_ptr_factory_.GetWeakPtr()));
```

You may choose to maintain only a single concurrent instance of your service
at a time, similar to the Network or Storage services. In this case, typically
you will have some browser code maintain a lazy Mojo Remote to the service
process, and any clients of the service will have their connections brokered
through this interface.

In other cases you may want to manage multiple independent service processes.
The Data Decoder service, for example, allows for arbitrary browser code
to launch a unique isolated instance to process a single decode operation or
a batch of related operations (e.g. to decode a bunch of different objects
from the same untrusted origin).

Insofar as the browser can use ServiceProcessLauncher however it likes, and the
corresponding Mojo Remotes can be owned just like any other object, developers
are free to manage their service instances however they like.

### Hooking Up the Service Implementation

For out-of-process service launching, Content uses its "utility" process type.

For services known to content, this is accomplished by adding an appropriate
factory function to
[`//content/utility/services.cc`](https://source.chromium.org/chromium/chromium/src/+/main:content/utility/services.cc;drc=main)

For other services known only to Chrome, we have a similar file at
[`//chrome/utility/services.cc`](https://source.chromium.org/chromium/chromium/src/+/main:chrome/utility/services.cc;drc=main).

**Modern Registration Pattern (v134+)**:

```cpp
// In content/utility/services.cc or chrome/utility/services.cc
void RegisterMyService(mojo::PendingReceiver<mojom::MyService> receiver) {
  static base::NoDestructor<std::unique_ptr<MyServiceImpl>> service;
  if (!*service) {
    *service = std::make_unique<MyServiceImpl>();
  }
  (*service)->BindReceiver(std::move(receiver));
}

// Register in the service map
auto RunMyService(mojo::PendingReceiver<mojom::MyService> receiver) {
  return std::make_unique<MyServiceImpl>(std::move(receiver));
}
```

Once an appropriate service factory is registered for your main service
interface in one of these places, `ServiceProcessHost::Launch` can be used to
acquire a new isolated instance from within the browser process.

To run a service in-process, you can simply instantiate your service
implementation (e.g. on a background thread) like you would any other object,
and you can then bind a Mojo Remote which is connected to that instance.

This is useful if you want to avoid the overhead of extra processes in some
scenarios, and it allows the detail of where and how the service runs to be
fully hidden behind management of the main interface''s Mojo Remote.

## Modern Service Architecture (v134+)

### Service Lifecycle Management

Modern services should implement proper lifecycle management:

```cpp
class MyServiceImpl : public mojom::MyService {
 public:
  explicit MyServiceImpl(mojo::PendingReceiver<mojom::MyService> receiver)
      : receiver_(this, std::move(receiver)) {
    receiver_.set_disconnect_handler(
        base::BindOnce(&MyServiceImpl::OnDisconnected, 
                       base::Unretained(this)));
  }

  ~MyServiceImpl() override = default;

  // mojom::MyService implementation
  void DoWork(const std::string& data, DoWorkCallback callback) override {
    // Implementation here
    std::move(callback).Run(ProcessData(data));
  }

 private:
  void OnDisconnected() {
    // Clean up resources
    // Service will be destroyed when this returns
  }

  mojo::Receiver<mojom::MyService> receiver_;
};
```

### Error Handling Patterns

Modern services should handle errors gracefully:

```cpp
void MyServiceImpl::ProcessRequest(ProcessRequestCallback callback) {
  if (!IsValidState()) {
    std::move(callback).Run(
        mojom::Result::NewError("Service in invalid state"));
    return;
  }

  // Process request...
  auto result = DoProcessing();
  if (result.has_value()) {
    std::move(callback).Run(mojom::Result::NewSuccess(result.value()));
  } else {
    std::move(callback).Run(
        mojom::Result::NewError("Processing failed"));
  }
}
```

### Security Considerations

- **Sandboxing**: All services should run in appropriate sandboxes
- **Input validation**: Validate all inputs at service boundaries
- **Capability-based access**: Limit service capabilities to minimum required
- **Process isolation**: Consider whether the service needs its own process

## Incremental Servicification

For large Chromium features it is not feasible to convert an entire subsystem
to a service all at once. As a result, it may be necessary for the subsystem
to spend a considerable amount of time (weeks or months) split between the old
implementation and your beautiful, sparkling new service implementation.

In creating your service, you likely have two goals:

- Making the service available to its consumers
- Making the service self-contained

Those two goals are not the same, and to some extent are at tension:

- To satisfy the first, you need to build out the API surface of the service to
  a sufficient degree for the anticipated use cases.

- To satisfy the second, you need to convert all clients of the code that you
  are servicifying to instead use the service, and then fold that code into the
  internal implementation of the service.

Whatever your goals, you will need to proceed incrementally if your project is
at all non-trivial (as they basically all are given the nature of the effort).
You should explicitly decide what your approach to incremental bringup and
conversion will be. Here are some approaches that have been taken for various
services:

- Build out your service depending directly on existing code,
  convert the clients of that code 1-by-1, and fold the existing code into the
  service implementation when complete. **Note**: Some legacy service designs used this pattern.
- Build out the service with new code and make the existing code
  into a client library of the service. In that fashion, all consumers of the
  existing code get converted transparently. **Note**: This pattern is less common in v134+.
- Build out the new service piece-by-piece by picking a given
  bite-size piece of functionality and entirely servicifying that functionality.
  **Recommended for v134+**: This approach ensures clean API boundaries from the start.

These all have tradeoffs:

- The first lets you incrementally validate your API and implementation, but
  leaves the service depending on external code for a long period of time.
- The second can create a self-contained service more quickly, but leaves
  all the existing clients in place as potential cleanup work.
- The third ensures that you''re being honest as you go, but delays having
  the breadth of the service API up and going.

Which makes sense depends both on the nature of the existing code and on
the priorities for doing the servicification. The first two enable making the
service available for new use cases sooner at the cost of leaving legacy code in
place longer, while the last is most suitable when you want to be very exacting
about doing the servicification cleanly as you go.

## Platform-Specific Issues: Android

As you servicify code running on Android, you might find that you need to port
interfaces that are served in Java. Here are modern patterns for handling this:

### JNI Integration in Services (v134+)

```cpp
// Modern JNI registration pattern
// service_jni_registrar.cc
#include "base/android/jni_registrar.h"
#include "my_service_jni_headers/MyServiceJni_jni.h"

namespace my_service {

bool RegisterJni(JNIEnv* env) {
  return base::android::RegisterNativeMethods(
      env, my_service::kMyServiceRegisteredMethods,
      my_service::kMyServiceRegisteredMethodsSize);
}

}  // namespace my_service
```

### Android Context Handling

Modern services should handle Android contexts through dependency injection:

```cpp
class AndroidServiceImpl : public mojom::AndroidService {
 public:
  explicit AndroidServiceImpl(
      mojo::PendingReceiver<mojom::AndroidService> receiver,
      base::android::ScopedJavaGlobalRef<jobject> context)
      : receiver_(this, std::move(receiver)),
        java_context_(std::move(context)) {}

 private:
  mojo::Receiver<mojom::AndroidService> receiver_;
  base::android::ScopedJavaGlobalRef<jobject> java_context_;
};
```

Finally, it is possible that your feature will have coupling to UI process state
(e.g., the Activity) via Android system APIs. To handle this challenging
issue, see the section on [Coupling to UI](#Coupling-to-UI).

## Platform-Specific Issues: iOS

*** aside
**Note for v134+:** iOS support for services has matured. All services run 
in-process on iOS due to platform constraints, but the same Mojo interfaces
work seamlessly across platforms.
***

Services are fully supported on iOS. However, Chrome on
iOS is strictly single-process, and all services thus must run in-process on
iOS. This is handled automatically by the service infrastructure.

Modern iOS service patterns:

```cpp
// iOS-specific service considerations
class MyServiceImpl : public mojom::MyService {
 public:
  explicit MyServiceImpl(mojo::PendingReceiver<mojom::MyService> receiver)
      : receiver_(this, std::move(receiver)) {
#if BUILDFLAG(IS_IOS)
    // iOS-specific initialization
    ConfigureForIOS();
#endif
  }

 private:
#if BUILDFLAG(IS_IOS)
  void ConfigureForIOS() {
    // Handle iOS-specific requirements
  }
#endif
  
  mojo::Receiver<mojom::MyService> receiver_;
};
```

## Client-Specific Issues

#### Mocking Interface Impls in JS
It is a common pattern in Blink''s web tests to mock a remote Mojo interface
in JS so that native Blink code requests interfaces from the test JS rather
than whatever would normally service them in the browser process.

The current way to set up that sort of thing uses modern Web Platform Tests (WPT) infrastructure:

```javascript
// Modern mock pattern for web tests
import {MyServiceReceiver} from ''/gen/my_service.mojom.m.js'';

class MockMyService {
  constructor() {
    this.receiver_ = new MyServiceReceiver(this);
    this.interceptor_ = new MojoInterfaceInterceptor(MyService.$interfaceName);
    this.interceptor_.oninterfacerequest = e => {
      this.receiver_.$.bindHandle(e.handle);
    };
    this.interceptor_.start();
  }

  // Implement service methods
  async doWork(data) {
    return {result: ''mocked_result''};
  }

  reset() {
    this.interceptor_.stop();
  }
}
```

#### Feature Impls That Depend on Blink Headers
In the course of servicifying a feature that has Blink as a client, you might
encounter cases where the feature implementation has dependencies on Blink
public headers (e.g., defining POD structs that are used both by the client and
by the feature implementation). These dependencies pose a challenge:

- Services should not depend on Blink, as this is a dependency inversion (Blink
is a client of services).
- However, Blink is very careful about accepting dependencies from Chromium.

To meet this challenge, you have these options:

1. **Move the code to mojom** (e.g., if it is simple structs) - Preferred for v134+
2. **Use shared common libraries** that both Blink and the service can depend on
3. Move the code into the service''s C++ client library, being very explicit
   about its usage by Blink.

**Modern Pattern (v134+)**:
```cpp
// Preferred: Define in mojom
module my_service.mojom;

struct SharedDataStructure {
  string name;
  int32 value;
  array<uint8> data;
};

interface MyService {
  ProcessData(SharedDataStructure data) => (bool success);
};
```

#### Frame-Scoped Connections
You must think carefully about the scoping of the connection being made
from Blink. In particular, some feature requests are necessarily scoped to a
frame in the context of Blink (e.g., geolocation, where permission to access the
interface is origin-scoped). Servicifying these features is then challenging, as
Blink has no frame-scoped connection to arbitrary services (by design, as
arbitrary services have no knowledge of frames or even a notion of what a frame
is).

After a
[long discussion](https://groups.google.com/a/chromium.org/forum/#!topic/services-dev/CSnDUjthAuw),
the policy that we have adopted for this challenge is the following:

**CURRENT (v134+) BEST PRACTICE:**

- The renderer makes a request through its frame-scoped connection to the
  browser (using `BrowserInterfaceBroker`).
- The browser validates permissions and origin constraints.
- The browser forwards the request to the underlying service, optionally
  including validated context information.

**Modern Implementation Pattern:**

```cpp
// In the browser process
void RenderFrameHostImpl::CreateMyService(
    mojo::PendingReceiver<mojom::MyService> receiver) {
  // Validate permissions for this frame/origin
  if (!IsAllowedForOrigin(GetLastCommittedOrigin())) {
    return;  // Reject the request
  }

  // Forward to the actual service with context
  GetMyService()->CreateFrameScopedInterface(
      std::move(receiver), 
      GetGlobalFrameRoutingId(),
      GetLastCommittedOrigin());
}
```

Notably, from the renderer''s POV essentially nothing changes here.

## Strategies for Challenges to Decoupling from //content

### Coupling to UI

Some feature implementations have hard constraints on coupling to UI on various
platforms. An example is NFC on Android, which requires the Activity of the view
in which the requesting client is hosted in order to access the NFC platform
APIs. This coupling is at odds with the vision of servicification, which is to
make the service physically isolatable. However, when it occurs, we need to
accommodate it.

The high-level decision that we have reached is to scope the coupling to the
feature *and* platform in question (rather than e.g. introducing a
general-purpose FooServiceDelegate), in order to make it completely explicit
what requires the coupling and to avoid the coupling creeping in scope.

The basic strategy to support this coupling while still servicifying the feature
in question is to inject a mechanism of mapping from an opaque "context ID" to
the required context. The embedder (e.g., //content) maintains this map, and the
service makes use of it. The embedder also serves as an intermediary: it
provides a connection that is appropriately context-scoped to clients. When
clients request the feature in question, the embedder forwards the request on
along with the appropriate context ID. The service impl can then map that
context ID back to the needed context on-demand using the mapping functionality
injected into the service impl.

**Modern Context Injection Pattern (v134+)**:

```cpp
// Service interface with context support
interface MyService {
  SetContextProvider(pending_remote<ContextProvider> provider);
  DoWorkWithContext(int32 context_id, string data) => (bool success);
};

// Implementation
class MyServiceImpl : public mojom::MyService {
 public:
  void SetContextProvider(
      mojo::PendingRemote<mojom::ContextProvider> provider) override {
    context_provider_.Bind(std::move(provider));
  }

  void DoWorkWithContext(int32 context_id, const std::string& data,
                        DoWorkWithContextCallback callback) override {
    context_provider_->GetContext(
        context_id,
        base::BindOnce(&MyServiceImpl::OnContextReceived,
                       weak_ptr_factory_.GetWeakPtr(),
                       data, std::move(callback)));
  }

 private:
  mojo::Remote<mojom::ContextProvider> context_provider_;
  base::WeakPtrFactory<MyServiceImpl> weak_ptr_factory_{this};
};
```

### Shutdown of Singletons

You might find that your feature includes singletons that are shut down as part
of //content''s shutdown process. As part of decoupling the feature
implementation entirely from //content, the shutdown of these singletons must be
either ported into your service or eliminated:

- **First priority (v134+)**: Eliminate the need for graceful shutdown entirely.
  Modern Chromium favors fast shutdown over graceful cleanup in most cases.
- If you need to preserve shutdown of the singleton, move the shutdown logic
  to the service''s destructor or implement a proper shutdown sequence.
- Carefully examine timing differences between old and new shutdown behavior.

**Modern Shutdown Pattern (v134+)**:

```cpp
class MyServiceImpl : public mojom::MyService {
 public:
  ~MyServiceImpl() override {
    // Clean shutdown if needed
    if (needs_cleanup_) {
      PerformCriticalCleanup();
    }
  }

  void Shutdown(ShutdownCallback callback) override {
    // Implement explicit shutdown if required
    PerformGracefulShutdown();
    std::move(callback).Run();
    
    // Service will be destroyed after callback
  }

 private:
  bool needs_cleanup_ = true;
};
```

## Modern Best Practices (v134+)

### Service Design Principles

1. **Single Responsibility**: Each service should have one clear purpose
2. **Minimal Dependencies**: Avoid coupling between services
3. **Testability**: Design services to be easily testable in isolation
4. **Error Handling**: Implement comprehensive error handling and recovery
5. **Performance**: Consider the overhead of process boundaries

### Testing Servicified Code

```cpp
// Modern service testing pattern
class MyServiceTest : public testing::Test {
 protected:
  void SetUp() override {
    service_impl_ = std::make_unique<MyServiceImpl>(
        service_remote_.BindNewPipeAndPassReceiver());
  }

  void TearDown() override {
    service_remote_.reset();
    service_impl_.reset();
    task_environment_.RunUntilIdle();
  }

  base::test::TaskEnvironment task_environment_;
  mojo::Remote<mojom::MyService> service_remote_;
  std::unique_ptr<MyServiceImpl> service_impl_;
};

TEST_F(MyServiceTest, BasicFunctionality) {
  base::test::TestFuture<bool> future;
  service_remote_->DoWork("test_data", future.GetCallback());
  EXPECT_TRUE(future.Get());
}
```

### Migration Checklist

When servicifying existing code:

- [ ] Define clear Mojo interfaces
- [ ] Implement proper error handling
- [ ] Add comprehensive tests
- [ ] Handle connection errors gracefully
- [ ] Consider security implications
- [ ] Document the service API
- [ ] Plan for incremental rollout
- [ ] Monitor performance impact

### Service Monitoring

Modern services should include monitoring and metrics:

```cpp
class MyServiceImpl : public mojom::MyService {
 private:
  void RecordMetrics(const std::string& operation, bool success) {
    base::UmaHistogramBoolean(
        base::StrCat({"MyService.", operation, ".Success"}), success);
  }
  
  void DoWork(const std::string& data, DoWorkCallback callback) override {
    base::TimeTicks start_time = base::TimeTicks::GETDATE();
    
    bool success = ProcessData(data);
    
    base::UmaHistogramTimes(
        "MyService.DoWork.Duration",
        base::TimeTicks::GETDATE() - start_time);
    RecordMetrics("DoWork", success);
    
    std::move(callback).Run(success);
  }
};
```

## Additional Support

If this document was not helpful in some way, please post a message to your
friendly local
[chromium-mojo@chromium.org](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-mojo)
or
[services-dev@chromium.org](https://groups.google.com/a/chromium.org/forum/#!forum/services-dev)
mailing list.
', NULL, N'apis', N'apis/servicification', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Mojo Testing', N'# Testing With Mojo (Chromium v134+)

This document outlines best practices and techniques for testing code which
internally uses a Mojo service in Chromium v134 and later. It assumes familiarity with the
[Mojo and Services](mojo_and_services.md) document.

**Note for v134+**: This document includes modern testing patterns, improved error handling,
and updated best practices that reflect current Chromium development standards.

## Example Code & Context

Suppose we have this Mojo interface:

```mojom
module example.mojom;

interface IncrementerService {
  Increment(int32 value) => (int32 new_value);
}
```

and this C++ class that uses it:

```c++
class Incrementer {
 public:
  explicit Incrementer();
  ~Incrementer();

  // Disallow copy and assign.
  Incrementer(const Incrementer&) = delete;
  Incrementer& operator=(const Incrementer&) = delete;

  void SetServiceForTesting(
      mojo::PendingRemote<example::mojom::IncrementerService> service);

  // The underlying service is async, so this method is too.
  void Increment(int32_t value, base::OnceCallback<void(int32_t)> callback);

 private:
  mojo::Remote<example::mojom::IncrementerService> service_;
};

void Incrementer::SetServiceForTesting(
    mojo::PendingRemote<example::mojom::IncrementerService> service) {
  service_.Bind(std::move(service));
}

void Incrementer::Increment(int32_t value, 
                           base::OnceCallback<void(int32_t)> callback) {
  if (!service_) {
    service_ = LaunchIncrementerService();
  }
  service_->Increment(value, std::move(callback));
}
```

and we wish to swap a test fake in for the underlying IncrementerService, so we
can unit-test Incrementer. Specifically, we''re trying to write this test:

```c++
// Test that Incrementer correctly handles when the IncrementerService fails to
// increment the value.
TEST(IncrementerTest, DetectsFailureToIncrement) {
  base::test::TaskEnvironment task_environment;
  
  Incrementer incrementer;
  FakeIncrementerService service;
  // ... somehow use `service` as a test fake for `incrementer` ...

  base::test::TestFuture<int32_t> future;
  incrementer.Increment(0, future.GetCallback());

  // Get the result and verify behavior
  EXPECT_EQ(0, future.Get());
}
```

## The Fake Service Itself

This part is fairly straightforward. Mojo generates a class called
`example::mojom::IncrementerService`, which is normally subclassed by
IncrementerServiceImpl (or whatever) in production; we can subclass it
ourselves:

```c++
class FakeIncrementerService : public example::mojom::IncrementerService {
 public:
  FakeIncrementerService() = default;
  ~FakeIncrementerService() override = default;

  // example::mojom::IncrementerService implementation:
  void Increment(int32_t value, IncrementCallback callback) override {
    // Does not actually increment, for test purposes!
    std::move(callback).Run(value);
  }

  // Test helper methods
  void SetShouldFail(bool should_fail) { should_fail_ = should_fail; }
  int32_t GetLastValue() const { return last_value_; }

 private:
  bool should_fail_ = false;
  int32_t last_value_ = 0;
};
```

## Async Services

We can plug the FakeIncrementerService into our test using:

```c++
TEST(IncrementerTest, BasicFunctionality) {
  base::test::TaskEnvironment task_environment;
  
  FakeIncrementerService fake_service;
  mojo::Receiver<example::mojom::IncrementerService> receiver{&fake_service};
  
  Incrementer incrementer;
  incrementer.SetServiceForTesting(receiver.BindNewPipeAndPassRemote());
  
  base::test::TestFuture<int32_t> future;
  incrementer.Increment(5, future.GetCallback());
  
  EXPECT_EQ(5, future.Get());  // Fake service doesn''t increment
}
```

we can invoke it and wait for the response using `base::test::TestFuture`:

```c++
  base::test::TestFuture<int32_t> test_future;
  incrementer.Increment(0, test_future.GetCallback());
  int32_t result = test_future.Get();
  EXPECT_EQ(0, result);
```

**Modern Testing Pattern (v134+)**: `base::test::TestFuture` is the preferred way to handle
asynchronous callbacks in tests, replacing older patterns like `base::RunLoop`.

... and all is well. However, we might reasonably want a more flexible
FakeIncrementerService, which allows for plugging different responses in as the
test progresses. In that case, we will actually need to wait twice: once for the
request to arrive at the FakeIncrementerService, and once for the response to be
delivered back to the Incrementer.

## Waiting For Requests

To do that, we can instead structure our fake service like this:

```c++
class FakeIncrementerService : public example::mojom::IncrementerService {
 public:
  FakeIncrementerService() = default;
  ~FakeIncrementerService() override = default;

  // example::mojom::IncrementerService implementation:
  void Increment(int32_t value, IncrementCallback callback) override {
    CHECK(!HasPendingRequest()) << "Multiple requests not supported";
    last_value_ = value;
    last_callback_ = std::move(callback);
    
    // Notify that a request has arrived
    if (request_waiter_.IsReady()) {
      request_waiter_.SetValue();
    }
  }

  bool HasPendingRequest() const {
    return !last_callback_.is_null();
  }

  void WaitForRequest() {
    if (HasPendingRequest()) {
      return;
    }
    request_waiter_.Clear();
    ASSERT_TRUE(request_waiter_.Wait()) << "Timeout waiting for request";
  }

  void RespondWithValue(int32_t response_value) {
    CHECK(HasPendingRequest()) << "No pending request to respond to";
    std::move(last_callback_).Run(response_value);
  }

  int32_t last_value() const { return last_value_; }

 private:
  int32_t last_value_ = 0;
  IncrementCallback last_callback_;
  base::test::TestFuture<void> request_waiter_;
};
```

That having been done, our test can now observe the state of the code under test
(in this case the Incrementer service) while the mojo request is pending, like
so:

```c++
TEST(IncrementerTest, HandlesPendingRequests) {
  base::test::TaskEnvironment task_environment;
  
  FakeIncrementerService service;
  mojo::Receiver<example::mojom::IncrementerService> receiver{&service};

  Incrementer incrementer;
  incrementer.SetServiceForTesting(receiver.BindNewPipeAndPassRemote());
  
  // Start the async operation
  base::test::TestFuture<int32_t> response_future;
  incrementer.Increment(42, response_future.GetCallback());

  // Wait for the request to arrive and verify the parameter
  service.WaitForRequest();
  EXPECT_EQ(42, service.last_value());
  
  // Respond with a modified value
  service.RespondWithValue(service.last_value() + 10);

  // Verify the final result
  EXPECT_EQ(52, response_future.Get());
}
```

This pattern is particularly useful for testing error conditions, timeouts, or
complex multi-step interactions.

## Modern Testing Patterns (v134+)

### Using MockReceiver for Simplified Testing

For simpler test scenarios, consider using `mojo::test::MockReceiver`:

```c++
#include "mojo/public/cpp/bindings/receiver.h"
#include "testing/gmock/include/gmock/gmock.h"

class MockIncrementerService : public example::mojom::IncrementerService {
 public:
  MockIncrementerService() = default;
  ~MockIncrementerService() override = default;

  MOCK_METHOD(void, Increment, 
              (int32_t value, IncrementCallback callback), 
              (override));
};

TEST(IncrementerTest, UsesService) {
  base::test::TaskEnvironment task_environment;
  
  MockIncrementerService mock_service;
  mojo::Receiver<example::mojom::IncrementerService> receiver{&mock_service};
  
  Incrementer incrementer;
  incrementer.SetServiceForTesting(receiver.BindNewPipeAndPassRemote());

  // Set expectations
  EXPECT_CALL(mock_service, Increment(42, testing::_))
      .WillOnce([](int32_t value, auto callback) {
        std::move(callback).Run(value + 7);
      });

  base::test::TestFuture<int32_t> future;
  incrementer.Increment(42, future.GetCallback());
  EXPECT_EQ(43, future.Get());
}
```

### Testing Connection Errors

Modern Chromium code should handle connection errors gracefully:

```c++
TEST(IncrementerTest, HandlesConnectionError) {
  base::test::TaskEnvironment task_environment;
  
  FakeIncrementerService service;
  mojo::Receiver<example::mojom::IncrementerService> receiver{&service};
  
  Incrementer incrementer;
  incrementer.SetServiceForTesting(receiver.BindNewPipeAndPassRemote());
  
  // Simulate connection error
  receiver.reset();
  task_environment.RunUntilIdle();
  
  // Test should handle this gracefully
  base::test::TestFuture<int32_t> future;
  incrementer.Increment(42, future.GetCallback());
  
  // Verify appropriate error handling behavior
  // (implementation depends on your error handling strategy)
}
```

## Intercepting Messages to Bound Receivers

In some cases, particularly in browser tests, we may want to take an existing,
bound `mojo::Receiver` and intercept certain messages to it. This allows us to:
 - modify message parameters before the message is handled by the original
   implementation,
 - modify returned values by intercepting callbacks,
 - introduce failures, or
 - completely re-implement the message handling logic

To accomplish this, Mojo autogenerates an InterceptorForTesting class for each
interface that can be subclassed to perform the interception. Continuing with
the example above, we can include `incrementer_service.mojom-test-utils.h` and
then use the following to intercept and replace the number to be incremented:

```c++
class IncrementerServiceInterceptor
    : public example::mojom::IncrementerServiceInterceptorForTesting {
 public:
  // We''ll assume RealIncrementerService implements the Mojo interface, owns
  // the bound mojo::Receiver, and makes it available via a testing
  // method we added named `receiver_for_testing()`.
  IncrementerServiceInterceptor(RealIncrementerService* service,
                                int32_t value_to_inject)
      : service_(service),
        value_to_inject_(value_to_inject),
        swapped_impl_(service->receiver_for_testing(), this) {}

  ~IncrementerServiceInterceptor() override = default;

  // Disallow copy and assign.
  IncrementerServiceInterceptor(const IncrementerServiceInterceptor&) = delete;
  IncrementerServiceInterceptor& operator=(const IncrementerServiceInterceptor&) = delete;

  example::mojom::IncrementerService* GetForwardingInterface() override {
    return service_;
  }

  void Increment(int32_t value, IncrementCallback callback) override {
    // Inject our test value instead of the original
    GetForwardingInterface()->Increment(value_to_inject_, std::move(callback));
  }

 private:
  raw_ptr<RealIncrementerService> service_;
  int32_t value_to_inject_;
  mojo::test::ScopedSwapImplForTesting<
      mojo::Receiver<example::mojom::IncrementerService>>
      swapped_impl_;
};
```

## Ensuring Message Delivery

Both `mojo::Remote` and `mojo::Receiver` objects have a `FlushForTesting()`
method that can be used to ensure that queued messages and replies have been
sent to the other end of the message pipe, respectively. `mojo::Remote` objects
also have an asynchronous version of this method called `FlushAsyncForTesting()`
that accepts a `base::OnceCallback` that will be called upon completion. These
methods can be particularly helpful in tests where the `mojo::Remote` and
`mojo::Receiver` might be in separate processes.

### Modern Flush Patterns (v134+)

```c++
TEST(IncrementerTest, FlushExample) {
  base::test::TaskEnvironment task_environment;
  
  FakeIncrementerService service;
  mojo::Receiver<example::mojom::IncrementerService> receiver{&service};
  
  Incrementer incrementer;
  auto remote = receiver.BindNewPipeAndPassRemote();
  incrementer.SetServiceForTesting(std::move(remote));
  
  // Send a message
  base::test::TestFuture<int32_t> future;
  incrementer.Increment(42, future.GetCallback());
  
  // Ensure all messages are flushed
  receiver.FlushForTesting();
  
  EXPECT_TRUE(service.HasPendingRequest());
  service.RespondWithValue(43);
  EXPECT_EQ(43, future.Get());
}
```

## Best Practices for Mojo Testing (v134+)

### 1. Use TaskEnvironment
Always include `base::test::TaskEnvironment` in your test fixtures:

```c++
class IncrementerTestBase : public testing::Test {
 protected:
  base::test::TaskEnvironment task_environment_;
};
```

### 2. Prefer TestFuture over RunLoop
Use `base::test::TestFuture` for waiting on callbacks instead of `base::RunLoop`:

```c++
// Preferred (v134+)
base::test::TestFuture<int32_t> future;
service->DoSomething(future.GetCallback());
int32_t result = future.Get();

// Avoid
base::RunLoop run_loop;
int32_t result;
service->DoSomething(base::BindLambdaForTesting([&](int32_t value) {
  result = value;
  run_loop.Quit();
}));
run_loop.Run();
```

### 3. Test Error Conditions
Always test what happens when Mojo connections fail:

```c++
TEST(IncrementerTest, HandlesDisconnection) {
  base::test::TaskEnvironment task_environment;
  
  mojo::Remote<example::mojom::IncrementerService> remote;
  auto receiver = remote.BindNewPipeAndPassReceiver();
  // Don''t bind the receiver - connection will fail
  
  Incrementer incrementer;
  incrementer.SetServiceForTesting(std::move(remote));
  
  base::test::TestFuture<int32_t> future;
  incrementer.Increment(42, future.GetCallback());
  
  // Test should handle connection error gracefully
  // (exact behavior depends on implementation)
}
```

### 4. Use Proper Cleanup
Ensure proper cleanup in test destructors:

```c++
class MyTestFixture : public testing::Test {
 protected:
  void TearDown() override {
    // Reset remotes and receivers explicitly if needed
    receiver_.reset();
    remote_.reset();
    task_environment_.RunUntilIdle();
  }
  
 private:
  base::test::TaskEnvironment task_environment_;
  mojo::Remote<example::mojom::IncrementerService> remote_;
  mojo::Receiver<example::mojom::IncrementerService> receiver_{&fake_service_};
  FakeIncrementerService fake_service_;
};
```

[Mojo and Services]: mojo_and_services.md
', NULL, N'apis', N'apis/mojo_testing', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Development Overview', N'# Development Workflow Overview

Effective Chromium development requires mastering a comprehensive set of tools, processes, and best practices. This section provides everything you need to become a productive Chromium contributor.

## What You''ll Learn

- **Version Control**: Advanced Git workflows for large codebases
- **Code Quality**: Tools and practices for maintaining high code quality
- **Review Process**: How to participate in Chromium''s code review culture
- **Language Guidelines**: Best practices for C++, Rust, and other languages

## Development Essentials

### Version Control Mastery
- [Git Cookbook](git_cookbook) - Common Git operations and workflows
- [Git Tips](git_tips) - Advanced Git techniques for Chromium development
- [Git Submodules](git_submodules) - Working with Chromium''s submodule dependencies

### Code Review & Collaboration
- [Code Reviews](code_reviews) - Chromium''s code review process and best practices

### Code Quality Tools
- [Clang Overview](clang) - Understanding Chromium''s primary compiler
- [ClangD Setup](clangd) - IDE integration for better development experience
- [Clang Format](clang_format) - Automated code formatting
- [Clang Tidy](clang_tidy) - Static analysis and code improvement suggestions
- [Clang Static Analyzer](clang_static_analyzer) - Advanced static analysis tools

### Language-Specific Guidelines
- [Rust in Chromium](rust) - Using Rust in the Chromium codebase
- [Rust Unsafe Guidelines](rust-unsafe) - Best practices for unsafe Rust code

### Maintenance & Operations
- [Clang Gardening](clang_gardening) - Maintaining the build infrastructure
- [Clang Sheriffing](clang_sheriffing) - Monitoring and maintaining code quality

## Tool Categories

### **Essential Daily Tools**
- Git (version control)
- Clang (compiler and toolchain)
- Code review system
- Build system (GN/Ninja)

### **Code Quality Tools**
- ClangFormat (formatting)
- ClangTidy (linting)
- Static analyzers
- Coverage tools

### **Advanced Tools**
- Refactoring tools
- Performance profilers
- Memory analyzers
- Security scanners

## Getting Started

1. **Start Here**: [Git Cookbook](git_cookbook) - Master the basics
2. **Next**: [Code Reviews](code_reviews) - Understand the review process  
3. **Then**: [Clang Overview](clang) - Set up your development environment
4. **Finally**: Choose language-specific guides based on your work

## Success Metrics

After completing this section, you should be able to:
- ✅ Navigate the Chromium codebase efficiently
- ✅ Submit well-formatted, high-quality patches
- ✅ Participate effectively in code reviews
- ✅ Use debugging and profiling tools confidently
- ✅ Follow Chromium''s coding standards and conventions

## Related Sections

- [Testing & QA](testing/testing_in_chromium) - Quality assurance practices
- [Performance](../performance/profiling) - Performance optimization tools
- [Contributing](../contributing/contributing) - How to contribute to Chromium
', NULL, N'development', N'development/overview', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Git Cookbook', N'# Git Cookbook

A collection of git recipes to do common git tasks.

See also [Git Tips](git_tips.md).

[TOC]

## Introduction

This is designed to be a cookbook for common command sequences/tasks relating to
git, git-cl, and how they work with Chromium development. It might be a little
light on explanations.

If you are new to git, or do not have much experience with a distributed version
control system, you should also check out
[The Git Community Book](http://book.git-scm.com/) for an overview of basic git
concepts and general git usage. Knowing what git means by branches, commits,
reverts, and resets (as opposed to what SVN means by them) will help make the
following much more understandable.

## Chromium-specific Git Extensions

Chromium ships a large number of git extensions in depot_tools. Some (like
`git cl`) are required for the Chromium development workflow, while others
(like `git map-branches`) are simple utilities to make your life easier.
Please take a look at the full
[depot_tools tutorial](https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html),
and at the extensive
[man pages](https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools.html)
for all the extensions.

## Excluding file(s) from git-cl, while preserving them for later use

Since git-cl assumes that the diff between your current branch and its tracking
branch is what should be used for the CL, the goal is to remove the unwanted
files from the current branch, and preserve them in another branch.

### Method #1: Reset your current branch, and selectively commit files

1.  `git log`  See the list of your commits. Find the hash of the last commit
     before your changes.
1.  `git reset --soft abcdef` where abcdef is the hash found in the step above.
1.  `git commit <files_for_this_cl> -m "files to upload"` commit the files you
     want included in the CL here.
1.  `git new-branch new_branch_name` Create a new branch for the
    files that you want to exclude.
1.  `git commit -a -m "preserved files"` Commit the rest of the files.

### Method #2: Create a new branch, reset, then commit files to preserve

This method creates a new branch from your current one to preserve your changes.
The commits on the new branch are undone, and then only the files you want to
preserve are recommitted.

1.  `git checkout -b new_branch_name` This preserves your old files.
1.  `git log` See the list of your commits. Find the hash of the last commit
    before your changes.
1.  `git reset --soft abcdef` Where abcdef is the hash found in the step above.
1.  `git commit <files_to_preserve> -m "preserved files"` Commit the found files
    into the `new_branch_name`.

Then revert your files however you''d like in your old branch. The files listed
in step 4 will be saved in `new_branch_name`

### Method #3: Cherry-pick changes into review branches

If you are systematic in creating separate local commits for independent
changes, you can make a number of different changes in the same client and then
cherry-pick each one into a separate review branch.

1.  Make and commit a set of independent changes.
1.  `git log`  # see the hashes for each of your commits.
1.  repeat checkout, cherry-pick, upload steps for each change 1..n
    1.  `git new-branch review-changeN` Create a new review branch
        tracking origin
    1.  `git cherry-pick <hash of change N>`
    1.  `git cl upload`

If a change needs updating due to review comments, you can go back to your main
working branch, update the commit, and re-cherry-pick it into the review branch.

1.  `git checkout <working branch>`
1.  Make changes.
1.  If the commit you want to update is the most recent one:
    1.  `git commit --amend <files>`
1.  If not:
    1.  `git commit <files>`
    1.  `git rebase -i origin`  # use interactive rebase to squash the new
        commit into the old one.
1.  `git log`  # observe new hash for the change
1.  `git checkout review-changeN`
1.  `git reset --hard`  # remove the previous version of the change
1.  `git cherry-pick <new hash of change N>`
1.  `git cl upload`

## Sharing code between multiple machines

Assume Windows computer named vista, and a Linux one named penguin.
Prerequisite: both machines have git clones of the main git tree.

```shell
vista$ git remote add linux ssh://penguin/path/to/git/repo
vista$ git fetch linux
vista$ git branch -a   # should show "linux/branchname"
vista$ git checkout -b foobar linux/foobar
vista$ hack hack hack; git commit -a
vista$ git push linux  # push branch back to linux
penguin$ git reset --hard  # update with new stuff in branch
```

Note that, by default, `gclient sync` will update all remotes. If your other
machine (i.e., `penguin` in the above example) is not always available,
`gclient sync` will timeout and fail trying to reach it. To fix this, you may
exclude your machine from being fetched by default:

    vista$ git config --bool remote.linux.skipDefaultUpdate true

## Reverting commits

The command `git revert X` patches in the inverse of a particular commit.
Using this command is one way of making a revert:

```shell
git checkout origin   # start with trunk
git revert abcdef
git cl upload
```

## Retrieving, or diffing against an old file revision

Git works in terms of commits, not files. Thus, working with the history of a
single file requires modified version of the show and diff commands.

```shell
# Find the commit you want in the file''s commit log.
git log path/to/file
# This prints out the file contents at commit 123abc.
git show 123abc:path/to/file
# Diff the current version against path/to/file against the version at
# path/to/file
git diff 123abc -- path/to/file
```

When invoking `git show` or `git diff`, the `path/to/file` is **not relative the
the current directory**. It must be the full path from the directory where the
.git directory lives. This is different from invoking `git log` which
understands relative paths.

## Reusing a Git mirror

If you have a nearby copy of a Git repo, you can quickly bootstrap your copy
from that one then adjust it to point it at the real upstream one.

1.  Clone a nearby copy of the code you want: `git clone coworker-machine:/path/to/repo`
1.  Change the URL your copy fetches from to point at the real git repo:
    `git remote set-url origin https://chromium.googlesource.com/chromium/src.git`
1.  Update your copy: `git fetch`
1.  Delete any extra branches that you picked up in the initial clone:
    `git prune origin`
', NULL, N'development', N'development/git_cookbook', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Git Tips', N'# Git Tips

When using Git, there are a few tips that are particularly useful when working
on the Chromium codebase, especially due to its size.

[TOC]

## Remember the basic git convention:

    git COMMAND [FLAGS] [ARGUMENTS]

Various git commands have underlying executable with a hyphenated name, such as
`git-grep`, but these can also be called via the `git` wrapper script as
`git grep` (and `man` should work either way too).

## Git references

The following resources can provide background on how Git works:

*   [Git-SVN Crash Course](http://git-scm.com/course/svn.html) -- this crash
    course is useful for Subversion users switching to Git.
*   [Think Like (a) Git](http://think-like-a-git.net/) -- does a great job of
    explaining the main purpose of Git operations.
*   [Git User''s Manual](http://schacon.github.com/git/user-manual.html) -- a
    great resource to learn more about ho to use Git properly.
*   [A Visual Git Reference](https://marklodato.github.io/visual-git-guide/index-en.html)
    -- a resource that explains various Git operations for visual learners.
*   [Git Cheat Sheet](http://cheat.errtheblog.com/s/git) -- now that you
    understand Git, here''s a cheat sheet to quickly remind you of all the
    commands you need.

## Optimizing (Speeding up) Git for a Large Repository

Git has numerous options, among which some are intended to optimize for large
repositories.
[feature.manyFiles](https://git-scm.com/docs/git-config#Documentation/git-config.txt-featuremanyFiles)
is a convenient option that turns on the group of options that optimize for
large repositories. Run the following inside the Chromium git repository:

    git config feature.manyFiles true

## Configuring the output of "git log"

By default, the date that "git log" displays is the "author date." In Chromium,
this generally corresponds to the date that the committed patch was last
uploaded. In most cases, however, the date that is of interest is the date that
the patch was committed in the tree. To configure "git log" to instead display
the latter date for your Chromium checkout, execute the following command:

```shell
git config format.pretty ''format:%C(auto,yellow)commit %H%C(auto)%d%nAuthor:    %an <%ae>%nCommitted: %cd%n%n%w(0,4,4)%B%-%n''
```

If you want to change *all* your repos (e.g., because you have multiple Chromium
checkouts and don''t care about having the default for other repos), add
"--global" after "config" in the above command.

## Committing changes

For a simple workflow (always commit all changed files, don''t keep local
revisions), the following script handles check; you may wish to call it `gci`
(git commit) or similar.

Amending a single revision is generally easier for various reasons, notably for
rebasing and for checking that CLs have been committed. However, if you don''t
use local revisions (a local branch with multiple revisions), you should make
sure to upload revisions periodically to code review if you ever need to go to
an old version of a CL.

```bash
#!/bin/bash
# Commit all, amending if not initial commit.
if git status | grep -q "Your branch is ahead of ''origin/main'' by 1 commit."
then
  git commit --all --amend
else
  git commit --all  # initial, not amendment
fi
```

## Listing and changing branches

```shell
git branch  # list branches
git checkout -  # change to last branch
```

To quickly list the 5 most recent branches, add the following to `.gitconfig`
in the `[alias]` section:

```shell
last5 = "!git for-each-ref --sort=committerdate refs/heads/ \
    --format=''%(committerdate:short) %(refname:short)'' | tail -5 | cut -c 12-"
```

A nicely color-coded list, sorted in descending order by date, can be made by
the following bash function:

```bash
git-list-branches-by-date() {
  local current_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
  local normal_text=$(echo -ne ''\E[0m'')
  local yellow_text=$(echo -ne ''\E[0;33m'')
  local yellow_bg=$(echo -ne ''\E[7;33m'')
  git for-each-ref --sort=-committerdate \
      --format=$''  %(refname:short)  \
          \t%(committerdate:short)\t%(authorname)\t%(objectname:short)'' \
          refs/heads \
      | column -t -s $''\t'' -n \
      | sed -E "s:^  (${current_branch}) :* ${yellow_bg}\1${normal_text} :" \
      | sed -E "s:^  ([^ ]+):  ${yellow_text}\1${normal_text}:"
}
```

## Searching

Use `git-grep` instead of `grep` and `git-ls-files` instead of `find`, as these
search only files in the index or _tracked_ files in the work tree, rather than
all files in the work tree.

Note that `git-ls-files` is rather simpler than `find`, so you''ll often need to
use `xargs` instead of `-exec` if you want to process matching files.

## Global changes

To make global changes across the source tree, it''s often easiest to use `sed`
with `git-ls-files`, using `-i` for in-place changing (this is generally safe,
as we don''t use symlinks much, but there are few places that do). Remember that
you don''t need to use `xargs`, since sed can take multiple input files. E.g., to
strip trailing whitespace from C++ and header files:

    sed -i -E ''s/\s+$//'' $(git ls-files ''*.cpp'' ''*.h'')


You may also find `git-grep` useful for limiting the scope of your changes,
using `-l` for listing files.

    sed -i -E ''...'' $(git grep -lw Foo ''*.cpp'' ''*.h'')

Remember that you can restrict sed actions to matching (or non-matching) lines.
For example, to skip lines with a line comment, use the following:

    ''\,//, ! s/foo/bar/g''

## Diffs

    git diff --shortstat

Displays summary statistics, such as:

    2104 files changed, 9309 insertions(+), 9309 deletions(-)
', NULL, N'development', N'development/git_tips', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Git Submodules', N'# Git submodules

A Git submodule is a Git repository inside another Git repository. Chromium
project doesn''t rely on Git submodules directly. Instead, gclient sync is used
to manage Git dependencies.

In 2023Q3, we started to move source of Git dependencies from DEPS files to Git
submodules. While we do our best to hide complexities of submodules, some will
be exposed.

[TOC]

## A quick introduction to Git submoduldes

[Git submodules](https://git-scm.com/docs/gitsubmodules) are managed via the
combination of `.gitmodules` files and gitlinks. `.gitmodules` is a text file
that configures submodules, and each submodule entry contains the path to the
submodule''s worktree and the URL of the submodule. Gitlink is a special type of
file in the Git database that tracks a submodule commit.

You can find an example of Git dependency below. Note that gclient-condition is
a custom property used by gclient and not git. It''s identical to `condition` in
`DEPS` and the allowed variables are defined in `vars = {` section of `DEPS`.

`.gitmodules`:

```
[submodule "third_party/catapult"]
	path = third_party/catapult
	url = https://chromium.googlesource.com/catapult.git
	gclient-condition = checkout_linux
```

gitlink entry, retrieved using `git ls-files -s -- third_party/catapult`:

```
160000 0b39a694c0b61392d1180520ed1c13e390029c41 0       third_party/catapult
```

Corresponding DEPS entry would look like:

```
  ''third_party/catapult'': {
    ''url'': ''https://chromium.googlesource.com/catapult.git@0b39a694c0b61392d1180520ed1c13e390029c41'',
    ''condition'': ''checkout_linux'',
}
```

## How to avoid accidental Git submodule updates?

The simplest approach is to always run gclient sync after updating chromium
checkout (e.g. after `git pull`, or `git checkout`). You can automate that by
adding post-checkout hook (example below). To confirm there are no changes, run
`git status`. If you use `git commit -a`, check the "Changes to be committed"
section that shows up in the edit commit message.

### Automatically run gclient sync after git pull / git checkout

We need to have Git two hooks: post-checkout and post-merge. In chromium/src
directory, edit `.git/hooks/post-checkout`:

```
#!/bin/sh

set -u
gclient sync
```

and set it to be executable: `chmod +x .git/hooks/post-checkout`. Repeat the
same for `.git/hooks/post-merge`.

More information about githooks can be found
[here](https://git-scm.com/docs/githooks).

### Git status shows modified dependencies. What does that mean?

If a submodule is checked out at a different commit than one tracked by its
parent, `git status` in the parent repo will show unstaged changes with "new
commits" in parenthesis, such as:

```
modified: <git deps name> (new commits)
```

Commands like `git commit -a` or `git add *|.|-A|u` WILL include this in your
commit and your CL (which is likely NOT what you want).

Instead you can:

```
# Run gclient sync to sync dependencies
gclient sync
# check git status again

# OR
git add <file> # for each file you want to stage
# Then commit your staged files
git commit -v -m "Fix foo/bar"
```

If a submodule has uncommitted changes (i.e. you made some manual changes to the
affected submodule), running `git status` in its parent repo will show them as
unstaged changes:

```
  modified: <git deps name> (modified content)

# or

  modified: <git deps name> (untracked content)
```

It''s not possible to add those changes to the parent repository. You can ignore
such status, or you can cd into submodule and address it. E.g. you may delete
untracked files (content) or reset modified content to match HEAD.

## I accidentally staged Git submodule (not yet committed)

If you accidentally stage a Git submodule, you can unstage it by running `git
restore --staged <path to submodule>`.

## I accidentally committed Git submodule

We will need to create either a commit that sets it back to old value, or amend
the commit that added it. You can try to run `gclient sync` to bring the commit
back to what is expected. If that doesn''t work, you can use `gclient setdep -r
<path>@<old hash>`, run `gclient gitmodules` to sync all submodules commits back
to what is in DEPS, or check detailed instructions in [Managing
dependencies](dependencies.md).

NOTE: setdep for chromium/src is always prefixed with src/. For example, if you
are updating v8, the command would be `gclient setdep -r src/v8@<hash>.

## Workflows with submodules

### Submodules during ''git status'', ''git commit'', and ''git add''

For `git status`, submodules that show up under `Changes not staged for commit`
can be hidden with `git -c diff.ignoreSubmodules=all status`

For `git commit -a` you can exclude all submodules with
`git -c diff.ignoreSubmodules=all commit -a`.

`git add` does NOT support `diff.ignoreSubmodules`. Submodules that were
hidden from you with `git -c diff.ignoreSubmodules=all status` would still
be staged with `git add .|--all|-A` and therefore committed with
`git -c diff.ignoreSubmodules=all commit`.

Instead you can run `git add '':(exclude,attr:builtin_objectmode=160000)''` which
will stage all changes except for submodules.

(git assigns `160000` as the objectmode submodules. You can read more about
[`builtin_objectmode`](https://kernel.googlesource.com/pub/scm/git/git/+/refs/heads/next/Documentation/gitattributes.txt#110)
and magic [pathspecs](https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpathspecapathspec))

To make these commands shorter, you can create git aliases for them by adding
the following to your $HOME/.gitconfig (globally) or src/.git/config file (just
chromium/src):
```
[alias]
        # ''s'', ''c'', or whatever alias you want for each command
        s = -c diff.ignoreSubmodules=all status
        c = -c diff.ignoreSubmodules=all commit -a
        d = -c diff.ignoreSubmodules=all difftool --dir-diff
        a = add '':(exclude,attr:builtin_objectmode=160000)''
```
With the above, you can execute these commands by running `git s`, `git c`, etc.
Or you may also use the pre-commit git hook detailed below.

### Understanding diff.ignoreSubmodules

`git config diff.ignoreSubmodules` sets a default behavior for `diff`, `status`,
and several other git subcommands, using one of the [supported values of
`--ignore-submodules`](https://www.git-scm.com/docs/git-diff/#Documentation/git-diff.txt---ignore-submodulesltwhengt).

By default, `gclient sync` sets this to `dirty` as a local config in the
chromium checkout. This elides submodule output for `git status` in a clean
checkout, but will show submodules as modified when developers locally touch
them.

Manually setting this to `all` elides such output in all cases. This also omits
submodule changes from `git commit -a`, which can decrease the likelihood of
accidental submodule commits. However, it does not omit such changes from
`git add -A`, meaning developers who use this flow are actually _more_ likely to
commit accidental changes, since they''ll be invisible beforehand unless
developers manually set `--ignore-submodules=dirty` or use a lower-level command
such as `git diff-tree`.

Because `all` can result in misleading output and doesn''t fully prevent
accidental submodule commits, typical developers are likely better-served by
leaving this configured to `dirty` and installing the
[commit hook described below](#install-hook) to prevent such commits.
Accordingly, `gclient sync` will warn if it detects a different setting locally;
developers who understand the consequences can silence the warning via the
`GCLIENT_SUPPRESS_SUBMODULE_WARNING` environment variable.

### Submodules during a ''git rebase-update''
While resolving merge conflicts during a `git rebase-update` you may see
submodules show up in unexpected places.

#### Submodules under "Changes not staged for commit"
Submodules under this section can be safely ignored. This simply shows that the
local commits of these submodules do not match the latest pinned commits fetched
from remote. In other words, these submodules have been rolled since your last
`git rebase-update`.

If you use a diff tool like meld you can run:
`git -c diff.ignoreSubmodules=all difftool --dir-diff`
to prevent these submodules from showing up in your diff tool.

#### Submodules under "Unmerged paths"
If Submodules show up under this section it means that new revisions were
committed for those submodules (either intentional or unintentionally) and these
submodules were also rolled at remote. So now there is a conflict.

If you DID NOT intentionally make any submdoules changes, you should run:
`gclient gitmodules`. This will update the submdoules for you, to match whatever
commits are listed in DEPS (which you have just pulled from remote).

If you DID intentionally roll submodules, you can resolve this conflict just by
resetting it:
`gclient setdep -r {path}@{hash}`

## Install a hook to help detect unintentional submodule commits {#install-hook}

depot_tools provides an opt-in pre-commit hook to detect unintentional submodule
 changes during `git commit` and remove them from the commit.

To install the hook: `gclient installhooks`

If there is an existing pre-commit hook, gclient will instruct you how to update
it. If you have already installed this hook, gclient will do nothing.

To uninstall the hook, in `chromium/src` `rm .git/hooks/pre-commit` if you have
no other hooks. Otherwise update `.git/hooks/pre-commit` to remove the gclient
provided hook.

To bypass this hook run `git commit --no-verify` (which bypasses all hooks you
 may have) OR set the following environment variable: `SKIP_GITLINK_PRECOMMIT=1`
(which bypasses this specific hook).

Note that this is currently and best effort solution and does not guarantee
that unintentional commits will always be detected. The team will iterate
quickly on this hook to fill in other gaps and behavior is subject to change.
Please file an [issue](https://bugs.chromium.org/p/chromium/issues/entry?components=Infra%3ESDK&labels=submodules-feedback&cc=sokcevic@chromium.org,jojwang@chromium.org&description=Please%20steps%20to%20reproduce%20the%20problem:%0A%0ADo%20you%20have%20any%20custom%20environment%20setups%20like%20git%20hooks%20or%20git%20configs%20that%20you%20have%20set%20yourself%0A%0APlease%20attach%20output%20of:%0Agit%20config%20-l%0Agit%20map-branches%20-vv%0A%0AIf%20this%20is%20an%20issue%20with%20git%20cl%20upload%20please%20include%20the%20git%20trace%20file%20for%20the%20problematic%20run%20found%20in:%0A%3Cdepot_tools_path%3E/traces/%3Clatest%20trace%3E) for any feedback.

## FAQ

### Why do we have Git dependencies in both DEPS and Git submodules?

Lots of Chromium infrastructure already parse DEPS file directly. Instead of a
massive switch, it''s easier to transition to Git submodules this way. Moreover,
unwanted Git submodule updates can be detected and developers can be warned.

### How do I manually roll Git submodule?

See the [dependencies](dependencies.md) page.

### I got a conflict on a submodule, how do I resolve it?

First, you will need to determine what is the right commit hash. If you
accidentally committed a gitlink, which got in the meantime updated, you most
likely want to restore the original updated gitlink. You can run `gclient
gitmodules`, which will take care of all unmerged submodule paths, and set it to
match DEPS file.

If you prefer to manually resolve it, under git status, you will see "Unmerged
paths". If those are submodules, you want to restore them by running the
following command:

```
git restore --staging <affected path>
```

### How do I see what revision is pinned?

`gclient getdep` will return whatever commit is pinned for the deps in `DEPS`
(unstaged, staged, or committed). If the repo is using git submodules only
(and has no git deps in `DEPS`) it will return the whatever pinned commit is
staged or committed.

```
gclient getdep -r <path>
```


If you want to keep your gitlink, then run `git add <affected path>`.

### How can I provide feedback?

Please file [a bug under Infra>SDK
component](https://bugs.chromium.org/p/chromium/issues/entry?components=Infra%3ESDK).
', NULL, N'development', N'development/git_submodules', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Code Reviews', N'# Code Reviews

Code reviews are a central part of developing high-quality code for Chromium.
All change lists (CLs) must be reviewed.

This page documents policy rules regarding code changes.

See also:
- The general patch, upload, and land process in [contributing code](contributing.md#code-review)
- [Code of conduct](../CODE_OF_CONDUCT.md)
- [Respectful Changes](cl_respect.md)
- [Respectful Code Reviews](cr_respect.md)
- The code review changes and OWNERS policy changes launched on March 24, 2021, see
[Mandatory Code Review and Native OWNERS](code_review_owners.md).

# Code review policies

Any [committer](https://www.chromium.org/getting-involved/become-a-committer/#what-is-a-committer) can review code, but
an owner must provide a review for each directory you are touching. Ideally you should choose
reviewers who are familiar with the area of code you are touching. If you have doubts, look
at the `git blame` for the file and the `OWNERS` files ([more info](#owners-files)).

To indicate a positive review, the reviewer provides a `Code-Review +1` in
Gerrit, also known as an LGTM ("Looks Good To Me"). A score of "-1" indicates
the change should not be submitted as-is.

Submissions to the chromium/src repository by a change contributor who is not a Chromium
committer require two committers to Code-Review+1 the submission. If the owner of the CL
is already a committer, then only one other committer is needed to review.

If you have multiple reviewers, provide a message indicating what you expect
from each reviewer. Otherwise people might assume their input is not required
or waste time with redundant reviews.

Please also read [Respectful Changes](cl_respect.md) and
[Respectful Code Reviews](cr_respect.md).

There are also a [collection of tips](cl_tips.md) for productive reviews, though
these are advisory and not policy.

#### Expectations for all reviewers

*   As a reviewer, aim to provide actionable feedback 3 times per work day. The
    expectation is that if you''re in the same time zone as the CL author, there
    are 3 review iterations. If there is a time zone divide, aim for 2 review
    iterations.

*   Use the status field in Gerrit settings to indicate if you''re away and when
    you''ll be back.

*   Don''t generally discourage people from sending you code reviews. This
    includes using a blanket "slow" in your status field.

## OWNERS files

In various directories there are files named `OWNERS` that list the email
addresses of people qualified to review changes in that directory. You must
get a positive review from an owner of each directory your change touches.

Owners files are recursive, so each file also applies to its subdirectories.
It''s generally best to pick more specific owners. People listed in higher-level
directories may have less experience with the code in question. For example,
the reviewers in the `//chrome/browser/component_name/OWNERS` file will likely
be more familiar with code in `//chrome/browser/component_name/sub_component`
than reviewers in the higher-level `//chrome/OWNERS` file.

More detail on the owners file format is provided [here](#owners-file-details).

*Tip:* The `git cl owners` command can help find owners. Gerrit also provides
this functionality in the Reviewers field of CLs.

While owners must approve all patches, any committer can contribute to the
review. In some directories the owners can be overloaded or there might be
people not listed as owners who are more familiar with the low-level code in
question. In these cases it''s common to request a low-level review from an
appropriate person, and then request a high-level owner review once that''s
complete. As always, be clear what you expect of each reviewer to avoid
duplicated work.

Owners do not have to pick other owners for reviews. Since they should already
be familiar with the code in question, a thorough review from any appropriate
committer is sufficient.

#### Expectations of owners

The existing owners of a directory approve additions to the list. It is
preferable to have many directories, each with a smaller number of specific
owners rather than large directories with many owners. Owners must be
[committers](https://www.chromium.org/getting-involved/become-a-committer/)
with at least 3 months'' tenure, and in addition should:

  * Demonstrate excellent judgment, teamwork and ability to uphold
    [Chromium development principles](contributing.md).

  * Be already acting as an owner, providing high-quality reviews and design
    feedback.

  * Have submitted a substantial number of non-trivial changes to the affected
    directory.

  * Have committed or reviewed substantial work to the affected directory
    within the last ninety days.

  * Have the bandwidth to contribute to reviews in a timely manner. If the load
    is unsustainable, work to expand the number of owners. Don''t try to
    discourage people from sending reviews, including writing "slow" or
    "emeritus" after your name.

Seldom-updated directories may have exceptions to the "substantiality" and
"recency" requirements.

Directories in `//third_party` should list those most familiar with the
library, regardless of how often the code is updated.

#### Removal of owners

If a code owner is not meeting the [expectations of
owners](#expectations-of-owners) listed above for more than one quarter (and
they are not on a leave during that time), then they may be removed by any
co-owner or an owner from the parent directory after a 4-week notice, using
the following process:

  * Upload a change removing the owner and copy all owners in that directory,
    including the owner in question.
  * If the affected owner approves the change, it may be landed immediately.
  * Otherwise, the change author must wait five working days for feedback from
    the other owners.
    * After that time has elapsed, if the change has received 3 approvals
      with no objections from anyone else, the change may be landed.
    * If the directory does not have 4 owners, then the decision should
      be escalated to the owners of the parent directory (or directories)
      as necessary to provide enough votes.
    * If there are objections, then the decision should be escalated to
      the [../ATL_OWNERS](../ATL_OWNERS) for resolution.

Note: For the purpose of not slowing down code review, Chromium removes
inactive owners (e.g., those who made no contributions for multiple quarters)
on a regular basis. The script does not take into account personal situations
like a long leave. If you were inactive only for a certain period of time
while you were on a long leave and have been meeting the above owner''s
expectations in other times, you can create a CL to re-add yourself and land
after getting local owner''s approval (you can refer to this policy in the CL).
The removal script will cc the removed owner and one other owner to avoid spam.

### OWNERS file details

Refer to the [owners plugin](https://github.com/GerritCodeReview/plugins_code-owners/blob/master/resources/Documentation/backend-find-owners.md)
for all details on the file format.

This example indicates that two people are owners, in addition to any owners
from the parent directory. `git cl owners` will list the comment after an
owner address, so this is a good place to include restrictions or special
instructions.
```
# You can include comments like this.
a@chromium.org
b@chromium.org  # Only for the frobinator.
```

A `*` indicates that all committers are owners:
```
*
```

The text `set noparent` will stop owner propagation from parent directories.
This should be rarely used. If you want to use `set noparent` except for IPC
related files, please first reach out to chrome-atls@google.com.

You have to use `set noparent` together with a reference to a file that lists
the owners for the given use case. Approved use cases are listed in
`//build/OWNERS.setnoparent`. Owners listed in those files are expected to
execute special governance functions such as ATL reviews or ipc security review.
Every set of owners should implement their own means of auditing membership. The
minimum expectation is that membership in those files is reevaluated on
project, or affiliation changes.

In this example, only the ATLs are owners:
```
set noparent
file://ATL_OWNERS
```

The `per-file` directive allows owners to be added that apply only to files
matching a pattern. In this example, owners from the parent directory
apply, plus one person for some classes of files, and all committers are
owners for the readme:
```
per-file foo_bar.cc=a@chromium.org
per-file foo.*=a@chromium.org

per-file readme.txt=*
```

Other `OWNERS` files can be included by reference by listing the path to the
file with `file://...`. This example indicates that only the people listed in
`//ipc/SECURITY_OWNERS` can review the messages files:
```
per-file *_messages*.h=set noparent
per-file *_messages*.h=file://ipc/SECURITY_OWNERS
```

File globbing is supported using the
[simple path expression](https://github.com/GerritCodeReview/plugins_code-owners/blob/master/resources/Documentation/path-expressions.md#simple-path-expressions)
format.

Owners annotated with `#{LAST_RESORT_SUGGESTION}` in their comment will be
omitted when suggesting code owners, except if dropping these code owners would
make the suggestion result empty or if these code owners are already reviewers
of the change.

### Owners-Override

Setting the `Owners-Override +1` label will bypass OWNERS enforcement. Active
[gardeners](gardener.md), Release Program Managers,
[Large Scale Changes](#large-scale-changes),
[Global Approvers](#global-approvals) reviewers,
[Chrome ATLs](../ATL_OWNERS)
have this capability. The power to use Owners-Override should be restricted
as follows:

  * Active gardeners and Release Program Managers can set Owners-Override only
    on CLs needed for gardening and releasing (e.g., revert, reland, test fix,
    cherry-pick).
  * Large Scale Change reviewers can set Owners-Override only on gardening CLs
    and CLs about the approved Large Scale Change.
  * Global approvers can set Owners-Override only on gardening CLs and
    mechanical CLs associated with their API changes. For example,
    //base/OWNERS can set Owners-Override on mechanical CLs associated with
    //base/ API changes.
  * Chrome ATLs can set Owners-Override on any changes to help with cases that
    cannot be handled by the above groups and expedite CLs when LSC is too
    heavyweight. However, please use one of the above groups before asking
    Chrome ATLs.

When you need Owners-Override on gardening CLs, please reach out to the
Active Sheriffs and Release Program Managers first. If none of them is
available, please send an email to lsc-owners-override@chromium.org for help.

Note that Owners-Override by itself is not enough on your own CLs. Where this
matters is when you are gardening. For example, if you want to revert or
disable a test, your Owners-Override on the CL is not enough. You also need
either another committer to LGTM the CL or, for clean reverts, a `Bot-Commit:
+1` from the [rubber-stamper bot](#automated-code_review).

When setting Owners-Override it is your responsibility to confirm that every
file (and line) in the patch has been appropriately reviewed.

## Mechanical changes

### Global Approvals
For one-off CLs, API owners of `base`, `build`, `content`,
`third_party/blink/public` and `url` can `Owners-Override +1` a change to their
APIs to avoid waiting for rubberstamp +1s from affected directories'' owners.
This should only be used for mechanical updates, but global approvers are free
to use their judgement in determining which mechanical changes they understand
well enough to approve (rather than limit strictly to calls into code
they own).

For a change that impacts many directories but doesn''t need area-specific
expertise to review, please ask any global approver or Chrome ATL to
approve the change rather than incur unnecessary review cost on a larger number
of reviewers.

### Large Scale Changes
You can use the [Large Scale Changes](process/lsc/large_scale_changes.md)
process to get approval to bypass OWNERS enforcement for large changes like
refactoring, architectural changes, or other repetitive code changes across the
whole codebase. This is used for work that span many dozen CLs.

## Documentation updates

Documentation updates require code review. We may revisit this decision in the
future.

## Automated code-review

For verifiably safe changes like translation files, clean reverts, and clean
cherry-picks, we have automation that will vote +1 on the `Bot-Commit` label
allowing the CL to be submitted without human code-review. Add `Rubber Stamper`
(rubber-stamper@appspot.gserviceaccount.com) to your CL as a reviewer to
activate this automation. It will scan the CL after about 1 minute and reply
with its verdict. `Bot-Commit` votes are not sticky between patchsets and so
only add the bot once the CL is finalized.

When combined with the [`Owners-Override`](#owners_override) power, gardeners
can effectively revert and reland on their own.

Rubber Stamper never provides OWNERS approval, by design. It''s intended to be
used by those who have owners in the directory modified or who are gardeners. If
it provided both code review and OWNERS approval, that would be an abuse vector:
that would allow anyone who can create a revert or cherry-pick to land it
without any other person being involved (e.g. the silent revert of security
patches).

Changes not supported by `Rubber Stamper` always need a +1 from another
committer.
', NULL, N'development', N'development/code_reviews', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Clang Overview', N'# Clang

Chromium ships a prebuilt [clang](http://clang.llvm.org) binary.
It''s just upstream clang built at a known-good revision that we
bump every two weeks or so.

This is the only supported compiler for building Chromium.

[TOC]

## Using gcc on Linux

`is_clang = false` will make the build use system gcc on Linux. There are no
bots that test this and there is no guarantee it will work, but we accept
patches for this configuration.

## Mailing List

https://groups.google.com/a/chromium.org/group/clang/topics

## Using plugins

The
[chromium style plugin](https://dev.chromium.org/developers/coding-style/chromium-style-checker-errors)
is used by default when clang is used.

If you''re working on the plugin, you can build it locally like so:

1.  Run `./tools/clang/scripts/build.py --without-android --without-fuchsia`
    to build the plugin.
1.  Run `ninja -C third_party/llvm-build/Release+Asserts/` to build incrementally.
1.  Build with clang like described above, but, if you use reclient, disable it.

To test the FindBadConstructs plugin, run:

    (cd tools/clang/plugins/tests && \
     ./test.py ../../../../third_party/llvm-build/Release+Asserts/bin/clang)

Since the plugin is rolled with clang changes, behavior changes to the plugin
should be guarded by flags to make it easy to roll clang. A general outline:
1.  Implement new plugin behavior behind a flag.
1.  Wait for a compiler roll to bring in the flag.
1.  Start passing the new flag in `GN` and verify the new behavior.
1.  Enable the new plugin behavior unconditionally and update the plugin to
    ignore the flag.
1.  Wait for another compiler roll.
1.  Stop passing the flag from `GN`.
1.  Remove the flag completely.

## Using the clang static analyzer

See [clang_static_analyzer.md](clang_static_analyzer.md).

## Windows

clang is the default compiler on Windows. It uses MSVC''s SDK, so you still need
to have Visual Studio with C++ support installed.

## Using a custom clang binary

Set `clang_base_path` in your args.gn to the llvm build directory containing
`bin/clang` (i.e. the directory you ran cmake). This must be an absolute
path. You also need to disable chromium''s clang plugin.

Here''s an example that also disables debug info and enables the component build
(both not strictly necessary, but they will speed up your build):

```
clang_base_path = getenv("HOME") + "/src/llvm-build"
clang_use_chrome_plugins = false
is_debug = false
symbol_level = 1
is_component_build = true
```

On Windows, for `clang_base_path` use something like this instead:

```
clang_base_path = "c:/src/llvm-build"
```

You can then look in `out/gn/toolchain.ninja` and check that the `rule cc` and
`rule cxx` commands run your clang binary.  If things look good, run `ninja
-C out/gn` to build.

Chromium tries to be buildable with its currently pinned clang, and with clang
trunk. Set `llvm_force_head_revision = true` in your args.gn if the clang you''re
trying to build with is closer to clang trunk than to Chromium''s pinned clang
(which `tools/clang/scripts/update.py --print-revision` prints).

## Related documents

* [Toolchain support](toolchain_support.md) gives an overview of clang
  rolls, and documents when to revert clang rolls and how to file good
  toolchain bugs.

* [Updating clang](updating_clang.md) documents the mechanics of updating clang,
  and which files are included in the default clang package.

* [Clang Sheriffing](clang_sheriffing.md) contains instructions for how to debug
  compiler bugs, for clang sheriffs.

* [Clang Tool Refactoring](clang_tool_refactoring.md) has notes on how to build
  and run refactoring tools based on clang''s libraries.

* [Updating Clang format binaries](updating_clang_format_binaries.md) has notes
  on how to update clang-format.
', NULL, N'development', N'development/clang', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'ClangD Setup', N'# Clangd

## Introduction

[clangd](https://clangd.llvm.org/) is a clang-based [language server](https://langserver.org/).
It brings IDE features (e.g. diagnostics, code completion, code navigations) to
your editor.

## Quick Start

* [Get clangd](#getting-clangd)
* Make sure generated ninja files are up-to-date
* Optional: build chrome normally to get generated headers
* Generate compilation database (note: it''s not regenerated automatically):
```
tools/clang/scripts/generate_compdb.py -p out/Default > compile_commands.json
```

*** note
Note: If you''re using a different build directory, you''ll need to replace `out/Default`
in this and other commands with your build directory.
***

* Indexing is enabled by default (since clangd 9), note that this might consume
  lots of CPU and RAM. There''s also a
  [remote-index service](https://github.com/clangd/chrome-remote-index/blob/main/docs/index.md)
  to have an instant project-wide index without consuming local resources
  (requires clangd 12+ built with remote index support).
* Use clangd in your favourite editor

## Getting clangd

For the best results, you should use a clangd that exactly matches the version
of Clang used by Chromium. This avoids problems like mismatched versions of
compiler diagnostics.

The easiest way to do this is to set the `checkout_clangd` var in `.gclient`:

```
solutions = [
  {
    "url": "https://chromium.googlesource.com/chromium/src.git",
    "managed": False,
    "name": "src",
    "custom_deps": {},
    "custom_vars": {
      "checkout_clangd": True,
    },
  },
]
```

After this, `gclient` will keep the binary at
`third_party/llvm-build/Release+Asserts/bin/clangd` in sync with the version of
Clang used by Chromium.

Alternatively, you may use the `build_clang_tools_extra.py` script to build
clangd from source:

```
tools/clang/scripts/build_clang_tools_extra.py --fetch out/Default clangd
```

The resulting binary will be at
`out/Default/tools/clang/third_party/llvm/build/bin/clangd`.

Once you have an appropriate clangd binary, you must configure your editor to
use it, either by placing it first on your `PATH`, or through editor-specific
configuration.

*** note
Note: The clangd provided by Chromium does not support optional features like
remote indexing (see https://crbug.com/1358258), such that `clangd --version`
will not mention `grpc`, and you will see “Unknown Index key External” warnings
in the clangd log.

If you want those features, you''ll need to use a different build of clangd,
such as the [clangd/clangd releases on
GitHub](https://github.com/clangd/clangd/releases).
***

## Setting Up

1. Make sure generated ninja files are up-to-date.

```
gn gen out/Default
```

2. Generate the compilation database, clangd needs it to know how to build a
source file.

```
tools/clang/scripts/generate_compdb.py -p out/Default > compile_commands.json
```

Note: the compilation database is not regenerated automatically. You need to
regenerate it manually whenever build rules change, e.g., when you have new files
checked in or when you sync to head.

If using Windows PowerShell, use the following command instead to set the
output''s encoding to UTF-8 (otherwise Clangd will hit "YAML:1:4: error: Got
empty plain scalar" while parsing it).

```
tools/clang/scripts/generate_compdb.py -p out/Default | out-file -encoding utf8 compile_commands.json
```

3. Optional: build chrome normally. This ensures generated headers exist and are
up-to-date. clangd will still work without this step, but it may give errors or
inaccurate results for files which depend on generated headers.

```
ninja -C out/Default chrome
```

4. Optional: configure clangd to use remote-index service for an instant
   project-wide index and reduced local CPU and RAM usage. See
   [instructions](https://github.com/clangd/chrome-remote-index/blob/main/docs/index.md).

5. Use clangd in your favourite editor, see detailed [instructions](
https://clangd.llvm.org/installation.html#editor-plugins).

    * Optional: You may want to add `--header-insertion=never` to the clangd
      flags, so that your editor doesn''t automatically add incorrect #include
      lines. The feature doesn''t correctly handle some common Chromium headers
      like `base/functional/callback_forward.h`.

## Background Indexing

clangd builds an incremental index of your project (all files listed in the
compilation database). The index improves code navigation features
(go-to-definition, find-references) and code completion.

* clangd only uses idle cores to build the index, you can limit the total amount
  of cores by passing the *-j=\<number\>* flag;
* the index is saved to the `.cache/clangd/index` in the project root; index
  shards for common headers e.g. STL will be stored in
  *$HOME/.cache/clangd/index*;
* background indexing can be disabled by the `--background-index=false` flag;
  Note that, disabling background-index will limit clangd’s knowledge about your
  codebase to files you are currently editing.

Note: the first index time may take hours (for reference, it took 2~3 hours on
a 48-core, 64GB machine). A full index of Chromium (including v8, blink) takes
~550 MB disk space and ~2.7 GB memory in clangd.

Note: [Remote-index service](https://github.com/clangd/chrome-remote-index/blob/main/docs/index.md)
replaces background-index with some downsides like being ~a day old (Clangd will
still know about your changes in the current editing session) and not covering
all configurations (not available for mac&windows specific code or non-main
branches).

## Questions

If you have any questions, reach out to
[clangd/clangd](https://github.com/clangd/clangd) or clangd-dev@lists.llvm.org.
', NULL, N'development', N'development/clangd', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Clang Format', N'# Using clang-format on Chromium C++ Code

[TOC]

*** note
NOTE: This page does not apply to the Chromium OS project. See [Chromium Issue
878506](https://bugs.chromium.org/p/chromium/issues/detail?id=878506#c10)
for updates.
***

## Easiest usage, from the command line

To automatically format a pending patch according to
[Chromium style](/styleguide/c++/c++.md), run: `git cl format` from the command
line. This should work on all platforms without any extra set up: the tool is
integrated with depot_tools and the Chromium checkout.

Like other `git-cl` commands, this operates on a diff relative to the upstream
branch. Only the lines that changed in a CL will be reformatted. To see what
clang-format would choose, commit any local changes and then run `git cl
format` followed by `git diff`. Alternatively, run `git cl format` and commit
the now-formatted code.

## Editor integrations

Many developers find it useful to integrate the clang-format tool with their
editor of choice. As a convenience, the scripts for this are also available in
your checkout of Chrome under
[src/third_party/clang-format/script/](https://source.chromium.org/chromium/chromium/src/+/HEAD:third_party/clang-format/script/).

If you use an editor integration, you should try to make sure that you''re using
the version of clang-format that comes with your checkout. That way, you''ll
automatically get updates and be running a tool that formats consistently with
other developers. The binary lives under `src/buildtools`, but it''s also in your
path indirectly via a `depot_tools` launcher script:
[clang-format](https://source.chromium.org/chromium/chromium/tools/depot_tools/+/HEAD:clang-format)
([clang-format.bat](https://source.chromium.org/chromium/chromium/tools/depot_tools/+/HEAD:clang-format.bat) on Windows). Assuming that `depot_tools` is in your editor''s `PATH`
and the editor command runs from a working directory inside the Chromium
checkout, the editor scripts (which anticipate clang-format on the path) should
work.

For further guidance on editor integration, see these specific pages:

*   [Sublime Text](https://www.chromium.org/developers/sublime-text#TOC-Format-selection-or-area-around-cursor-using-clang-format)
*   [llvm''s guidelines for vim, emacs, and bbedit](http://clang.llvm.org/docs/ClangFormat.html)
*   [Visual Studio Code](https://chromium.googlesource.com/chromium/src/+/HEAD/docs/vscode.md#useful-extensions)
*   For vim, `:so tools/vim/clang-format.vim` and then hit cmd-shift-i (mac)
    ctrl-shift-i (elsewhere) to indent the current line or current selection.

## Reporting problems

If clang-format is broken, or produces badly formatted code, please file a
[bug]. Assign it to thakis@chromium.org or dcheng@chromium.org, who will route
it upstream.

[bug]:
https://code.google.com/p/chromium/issues/entry?comment=clang-format%20produced%20code%20that%20(choose%20all%20that%20apply):%20%0A-%20Doesn%27t%20match%20Chromium%20style%0A-%20Doesn%27t%20match%20blink%20style%0A-%20Riles%20my%20finely%20honed%20stylistic%20dander%0A-%20No%20sane%20human%20would%20ever%20choose%0A%0AHere%27s%20the%20code%20before%20formatting:%0A%0A%0AHere%27s%20the%20code%20after%20formatting:%0A%0A%0AHere%27s%20how%20it%20ought%20to%20look:%0A%0A%0ACode%20review%20link%20for%20full%20files/context:&summary=clang-format%20quality%20problem&cc=thakis@chromium.org&labels=Type-Bug,Build-Tools,OS-?,clang-format

## Are robots taking over my freedom to choose where newlines go?

Mostly. At upload time, a presubmit check warns if a CL is not clang-formatted,
but this is a non-blocking warning, and the CL may still be submitted. Even so,
try to prefer clang-format''s output when possible:

- While clang-format does not necessarily format code the exact same way a human
  might choose, it produces style-conformat code by design. This can allow
  development and review time to be focused on discovering functional defects,
  addressing readability/understandability concerns that can''t be automatically
  fixed by tooling, et cetera.
- Continually fighting the tooling is a losing battle. Most Chromium developers
  use clang-format. Large-scale changes will simply run `git cl format` once to
  avoid having to deal with the particulars of formatting. Over time, this will
  likely undo any carefully-curated manual formatting of the affected lines.

There is one notable exception where clang-format is often disabled: large
tables of data are often surrounded by `// clang-format off` and `//
clang-format on`. Try to use this option sparingly, as widespread usage makes
tool-assisted refactoring more difficult.

Again, if clang-format produces something odd, please err on the side of
[reporting an issue](#Reporting-problems): bugs that aren''t reported can''t be
fixed.
', NULL, N'development', N'development/clang_format', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Clang Tidy', N'# Clang Tidy

[TOC]

## Introduction

[clang-tidy](http://clang.llvm.org/extra/clang-tidy/) is a clang-based C++
“linter” tool. Its purpose is to provide an extensible framework for diagnosing
and fixing typical programming errors, like style violations, interface misuse,
or bugs that can be deduced via static analysis.

## Where is it?

clang-tidy is available in two places in Chromium:

- In Chromium checkouts
- In code review on Gerrit

Clang-tidy automatically runs on any CL that Chromium committers upload to
Gerrit, and will leave code review comments there. This is the recommended way
of using clang-tidy.

## Enabled checks

Chromium globally enables a subset of all of clang-tidy''s checks (see
`${chromium}/src/.clang-tidy`). We want these checks to cover as much as we
reasonably can, but we also strive to strike a reasonable balance between signal
and noise on code reviews. Hence, a large number of clang-tidy checks are
disabled.

### Adding a new check

New checks require review from cxx@chromium.org. If you propose a check and it
gets approved, you may turn it on, though please note that this is only
provisional approval: we get signal from users clicking "Not Useful" on
comments. If feedback is overwhelmingly "users don''t find this useful," the
check may be removed.

Traditionally, petitions to add checks include [an
evaluation](https://docs.google.com/document/d/1i1KmXtDD4j_qjhmAdGlJ6UkYXByVX1Kp952Zusdcl5k/edit?usp=sharing)
of the check under review. Crucially, this includes two things:

- a count of how many times this check fires across Chromium
- a random sample (>30) of places where the check fires across Chromium

It''s expected that the person proposing the check has manually surveyed every
clang-tidy diagnostic in the sample, noting any bugs, odd behaviors, or
interesting patterns they''ve noticed. If clang-tidy emits FixIts, these are
expected to be considered by the evaluation, too.

An example of a previous proposal email thread is
[here](https://groups.google.com/a/chromium.org/g/cxx/c/iZ6-Y9ZhC3Q/m/g-8HzqmbAAAJ).

#### Evaluating: running clang-tidy across Chromium

Running clang-tidy requires some setup. First, you''ll need to sync clang-tidy,
which requires adding `checkout_clang_tidy` to your `.gclient` file:

```
solutions = [
  {
    ''custom_vars'': {
      ''checkout_clang_tidy'': True,
    },
  }
]
```

Your next run of `gclient runhooks` should cause clang-tidy to be synced.

To run clang-tidy across all of Chromium, you''ll need a checkout of Chromium''s
[tools/build/](https://chromium.googlesource.com/chromium/tools/build) repository.
Once you have that and a Chromium `out/` dir with an `args.gn`, running
clang-tidy across all of Chromium is a single command:

```
$ cd ${chromium}/src
$ ${chromium_tools_build}/recipes/recipe_modules/tricium_clang_tidy/resources/tricium_clang_tidy_script.py \
    --base_path $PWD \
    --out_dir out/Linux \
    --findings_file all_findings.json \
    --clang_tidy_binary $PWD/third_party/llvm-build/Release+Asserts/bin/clang-tidy \
    --all
```

To only run clang-tidy against certain files, replace the `--all` parameter with
the individual file paths.

All clang-tidy checks are run on Linux builds of Chromium, so please set up your
`args.gn` to build Linux.

`all_findings.json` is where all of clang-tidy''s findings will be dumped. The
format of this file is detailed in `tricium_clang_tidy_script.py`.

**Note** that the above command will use Chromium''s top-level `.clang-tidy` file
(or `.clang-tidy` files scattered throughout `third_party/`, depending on the
files we lint. In order to test a *new* check, it''s recommended that you use
`tricium_clang_tidy_script.py`''s `--tidy_checks` flag. Usage of this looks like:

```
$ cd ${chromium}/src
$ ${chromium_build}/recipes/recipe_modules/tricium_clang_tidy/resources/tricium_clang_tidy_script.py \
    --base_path $PWD \
    --out_dir out/Linux \
    --findings_file all_findings.json \
    --clang_tidy_binary $PWD/third_party/llvm-build/Release+Asserts/bin/clang-tidy \
    --tidy_checks=''-*,YOUR-NEW-CHECK-NAME-HERE''
    --all
```

### Ignoring a check

If a check is invalid on a particular piece of code, clang-tidy supports `//
NOLINT` and `// NOLINTNEXTLINE` for ignoring all lint checks in the current and
next lines, respectively. To suppress a specific lint, you can put it in
parenthesis, e.g., `// NOLINTNEXTLINE(modernize-use-nullptr)`. For more, please
see [the documentation](
https://clang.llvm.org/extra/clang-tidy/#suppressing-undesired-diagnostics).

**Please note** that adding comments that exist only to silence clang-tidy is
actively discouraged. These comments clutter code, can easily get
out-of-date, and don''t provide much value to readers. Moreover, clang-tidy only
complains on Gerrit when lines are touched, and making Chromium clang-tidy clean
is an explicit non-goal; making code less readable in order to silence a
rarely-surfaced complaint isn''t a good trade-off.

If clang-tidy emits a diagnostic that''s incorrect due to a subtlety in the code,
adding an explanantion of what the code is doing with a trailing `NOLINT` may be
fine. Put differently, the comment should be able to stand on its own even if we
removed the `NOLINT`. The fact that the comment also silences clang-tidy is a
convenient side-effect.

For example:

Not OK; comment exists just to silence clang-tidy:

```
// NOLINTNEXTLINE
for (int i = 0; i < arr.size(); i++) {
  // ...
}
```

Not OK; comment exists just to verbosely silence clang-tidy:

```
// Clang-tidy doesn''t get that we can''t range-for-ize this loop. NOLINTNEXTLINE
for (int i = 0; i < arr.size(); i++) {
  // ...
}
```

Not OK; it''s obvious that this loop modifies `arr`, so the comment doesn''t
actually clarify anything:

```
// It''d be invalid to make this into a range-for loop, since the body might add
// elements to `arr`. NOLINTNEXTLINE
for (int i = 0; i < arr.size(); i++) {
  if (i % 4) {
    arr.push_back(4);
    arr.push_back(2);
  }
}
```

OK; comment calls out a non-obvious property of this loop''s body. As an
afterthought, it silences clang-tidy:

```
// It''d be invalid to make this into a range-for loop, since the call to `foo`
// here might add elements to `arr`. NOLINTNEXTLINE
for (int i = 0; i < arr.size(); i++) {
  foo();
  bar();
}
```

In the end, as always, what is and isn''t obvious at some point is highly
context-dependent. Please use your best judgement.

## But I want to run it locally

If you want to sync the officially-supported `clang-tidy` to your workstation,
add the following to your .gclient file:

```
solutions = [
  {
    ''custom_vars'': {
      ''checkout_clang_tidy'': True,
    },
  },
]
```

If you already have `solutions` and `custom_vars`, just add
`checkout_clang_tidy` to the existing `custom_vars` map.

Once the above update has been made, run `gclient runhooks`, and clang-tidy
should appear at `src/third_party/llvm-build/Release+Asserts/bin/clang-tidy` if
your Chromium tree is sufficiently up-to-date.

### Running clang-tidy locally

**Note** that the local flows with clang-tidy are experimental, and require an
LLVM checkout. Tricium is happy to run on WIP CLs, and we strongly encourage its
use.

That said, assuming you have the LLVM sources available, you''ll need to bring
your own `clang-apply-replacements` binary if you want to use the `-fix` option
noted below.

**Note:** If you''re on a system that offers a clang tools through its package
manager (e.g., on Debian/Ubuntu, `sudo apt-get install clang-tidy clang-tools`),
you might not need an LLVM checkout to make the required binaries and scripts
(`clang-tidy`, `run-clang-tidy` and `clang-apply-replacements`) available in
your `$PATH`. However, the system packaged binaries might be several versions
behind Chromium''s toolchain, so not all flags are guaranteed to work. If this is
a problem, consider building clang-tidy from the same revision the current
toolchain is using, rather than filing a bug against the toolchain component.
This can be done as follows:
```
tools/clang/scripts/build_clang_tools_extra.py \
    --fetch out/Release clang-tidy clang-apply-replacements
```
Running clang-tidy is then (hopefully) simple.
1.  Build chrome normally.
```
ninja -C out/Release chrome
```
2.  Export Chrome''s compile command database
```
gn gen out/Release --export-compile-commands
```
3.  Enter the build directory
```
cd out/Release
```
4.  Run clang-tidy.
```
<PATH_TO_LLVM_SRC>/clang-tools-extra/clang-tidy/tool/run-clang-tidy.py \
    -p . \# Set the root project directory, where compile_commands.json is.
    # Set the clang-tidy binary path, if it''s not in your $PATH.
    -clang-tidy-binary <PATH_TO_LLVM_BUILD>/bin/clang-tidy \
    # Set the clang-apply-replacements binary path, if it''s not in your $PATH
    # and you are using the `fix` behavior of clang-tidy.
    -clang-apply-replacements-binary \
        <PATH_TO_LLVM_BUILD>/bin/clang-apply-replacements \
    # The checks to employ in the build. Use `-*,...` to omit default checks.
    -checks=<CHECKS> \
    -header-filter=<FILTER> \# Optional, limit results to only certain files.
    -fix \# Optional, used if you want to have clang-tidy auto-fix errors.
    ''chrome/browser/.*'' # A regex of the files you want to check.

Copy-Paste Friendly (though you''ll still need to stub in the variables):
<PATH_TO_LLVM_SRC>/clang-tools-extra/clang-tidy/tool/run-clang-tidy.py \
    -p . \
    -clang-tidy-binary <PATH_TO_LLVM_BUILD>/bin/clang-tidy \
    -clang-apply-replacements-binary \
        <PATH_TO_LLVM_BUILD>/bin/clang-apply-replacements \
    -checks=<CHECKS> \
    -header-filter=<FILTER> \
    -fix \
    ''chrome/browser/.*''
```

Note that the source file regex must match how the build specified the file.
This means that on Windows, you must use (escaped) backslashes even from a bash
shell.

### Questions

Questions about the local flow? Reach out to rdevlin.cronin@chromium.org,
thakis@chromium.org, or gbiv@chromium.org.

Questions about the Gerrit flow? Email tricium-dev@google.com or
infra-dev+tricium@chromium.org, or file a bug against `Infra>LUCI>BuildService>PreSubmit>Tricium`.
Please CC gbiv@chromium.org and dcheng@chromium.org on any of these.

Discoveries? Update the doc!
', NULL, N'development', N'development/clang_tidy', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Clang Static Analyzer', N'# The Clang Static Analyzer

The Clang C/C++ compiler comes with a static analyzer which can be used to find
bugs using path sensitive analysis. Path sensitive analysis is
a technique that explores all the possible branches in code and
records the codepaths that might lead to bad or undefined behavior,
like an uninitialized reads, use after frees, pointer leaks, and so on.

See the [official Clang static analyzer page](http://clang-analyzer.llvm.org/)
for more background information.

We used to have a bot that continuously ran with the static analyzer,
but people used to not look at it much.

The static analyzer can still be invoked with [clang-tidy](clang_tidy.md).

## Recommended checks
Clang''s static analyzer comes with a wide variety of checkers. Some of the
checks aren''t useful because they are intended for different languages,
platforms, or coding conventions than the ones used for Chromium development.

Checkers we found useful were:

    -analyzer-checker=core
    -analyzer-checker=cpp
    -analyzer-checker=unix
    -analyzer-checker=deadcode

As of this writing, the checker suites we support are
[core](https://clang-analyzer.llvm.org/available_checks.html#core_checkers),
[cplusplus](https://clang-analyzer.llvm.org/available_checks.html#cplusplus_checkers), and
[deadcode](https://clang-analyzer.llvm.org/available_checks.html#deadcode_checkers).

To easily run these checks against Chromium code via clang-tidy, follow
[these](clang_tidy.md#evaluating_running-clang_tidy-across-chromium)
instructions to pull down `tricium_clang_tidy.py` and then pass the following
argument when invoking the script (`-*` disables all checks and then the
remaining check name globs enable each category of checks):
```
--tidy_checks="-*,clang-analyzer-core*,clang-analyzer-cplusplus*,clang-analyzer-unix*,clang-analyzer-deadcode*"
```
A full list of Clang analyzer checks can be found in the
[Clang-Tidy Checks List](https://clang.llvm.org/extra/clang-tidy/checks/list.html).

## Addressing false positives

Some of the errors you encounter will be false positives, which occurs when the
static analyzer naively follows codepaths which are practically impossible to
hit at runtime. Fortunately, we have a tool at our disposal for guiding the
analyzer away from impossible codepaths: assertion handlers like
DCHECK/CHECK/LOG(FATAL).  The analyzer won''t check the codepaths which we
assert are unreachable.

An example would be that if the analyzer detected the function argument
`*my_ptr` might be null and dereferencing it would potentially segfault, you
would see the error `warning: Dereference of null pointer (loaded from variable
''my_ptr'')`.  If you know for a fact that my_ptr will not be null in practice,
then you can place an assert at the top of the function: `DCHECK(my_ptr)`. The
analyzer will no longer generate the warning.

Be mindful about only specifying assertions which are factually correct! Don''t
DCHECK recklessly just to quiet down the analyzer. :)

Other types of false positives and their suppressions:
* Unreachable code paths. To suppress, add the `ANALYZER_SKIP_THIS_PATH();`
  directive to the relevant code block.
* Dead stores. To suppress, use `[[maybe_unused]]`. This also suppresses dead
  store warnings on conventional builds without static analysis enabled!

See the definitions of the `ANALYZER_*` macros in base/logging.h for more
detailed information about how the annotations are implemented.

## Logging bugs

If you find any issues with the static analyzer, or find Chromium code behaving
badly with the analyzer, please check the `Infra>CodeAnalysis` CrBug component
to look for known issues, or file a bug if it is a new problem.
', NULL, N'development', N'development/clang_static_analyzer', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Clang Tool Refactoring', N'# Clang Tool Refactoring

[TOC]

## Introduction

Clang tools can help with global refactorings of Chromium code. Clang tools can
take advantage of clang''s AST to perform refactorings that would be impossible
with a traditional find-and-replace regexp:

*   Constructing `scoped_ptr<T>` from `NULL`: <https://crbug.com/173286>
*   Implicit conversions of `scoped_refptr<T>` to `T*`: <https://crbug.com/110610>
*   Rename everything in Blink to follow Chromium style: <https://crbug.com/563793>
*   Clean up of deprecated `base::Value` APIs: <https://crbug.com/581865>

## Caveats

* Invocations of a clang tool runs on on only one build config at a time. For
example, running the tool across a `target_os="win"` build won''t update code
that is guarded by `OS_POSIX`. Performing a global refactoring will often
require running the tool once for each build config.

## Prerequisites

A Chromium checkout created with `fetch` should have everything needed.

For convenience, add `third_party/llvm-build/Release+Asserts/bin` to `$PATH`.

## Writing the tool

LLVM uses C++11 and CMake. Source code for Chromium clang tools lives in
[//tools/clang]. It is generally easiest to use one of the already-written tools
as the base for writing a new tool.

Chromium clang tools generally follow this pattern:

1.  Instantiate a
    [`clang::ast_matchers::MatchFinder`][clang-docs-match-finder].
2.  Call `addMatcher()` to register
    [`clang::ast_matchers::MatchFinder::MatchCallback`][clang-docs-match-callback]
    actions to execute when [matching][matcher-reference] the AST.
3.  Create a new `clang::tooling::FrontendActionFactory` from the `MatchFinder`.
4.  Run the action across the specified files with
    [`clang::tooling::ClangTool::run`][clang-docs-clang-tool-run].
5.  Serialize generated [`clang::tooling::Replacement`][clang-docs-replacement]s
    to `stdout`.

Other useful references when writing the tool:

*   [Clang doxygen reference][clang-docs]
*   [Tutorial for building tools using LibTooling and
    LibASTMatchers][clang-tooling-tutorial]

### Edit serialization format
```
==== BEGIN EDITS ====
r:::path/to/file/to/edit:::offset1:::length1:::replacement text
r:::path/to/file/to/edit:::offset2:::length2:::replacement text
r:::path/to/file2/to/edit:::offset3:::length3:::replacement text
include-user-header:::path/to/file2/to/edit:::-1:::-1:::header/file/to/include.h

       ...

==== END EDITS ====
```

The header and footer are required. Each line between the header and footer
represents one edit. Fields are separated by `:::`, and the first field must
be `r` (for replacement) or `include-user-header`.
A deletion is an edit with no replacement text.

The edits are applied by [`apply_edits.py`](#Running), which understands certain
conventions:

*   The clang tool should munge newlines in replacement text to `\0`. The script
    knows to translate `\0` back to newlines when applying edits.
*   When removing an element from a ''list'' (e.g. function parameters,
    initializers), the clang tool should emit a deletion for just the element.
    The script understands how to extend the deletion to remove commas, etc. as
    needed.

TODO: Document more about `SourceLocation` and how spelling loc differs from
expansion loc, etc.

### Why not RefactoringTool?
While clang has a [`clang::tooling::RefactoringTool`](http://clang.llvm.org/doxygen/classclang_1_1tooling_1_1RefactoringTool.html)
to automatically apply the generated replacements and save the results, it
doesn''t work well for Chromium:

*   Clang tools run actions serially, so run time scales poorly to tens of
    thousands of files.
*   A parsing error in any file (quite common in NaCl source) prevents any of
    the generated replacements from being applied.

## Building
Synopsis:

```shell
tools/clang/scripts/build.py --bootstrap --without-android --without-fuchsia \
  --extra-tools rewrite_to_chrome_style
```

Running this command builds the [Oilpan plugin][//tools/clang/blink_gc_plugin],
the [Chrome style plugin][//tools/clang/plugins], and the [Blink to Chrome style
rewriter][//tools/clang/rewrite_to_chrome_style]. Additional arguments to
`--extra-tools` should be the name of subdirectories in [//tools/clang].

It is important to use --bootstrap as there appear to be [bugs](https://crbug.com/580745)
in the clang library this script produces if you build it with gcc, which is the default.

Once clang is bootsrapped, incremental builds can be done by invoking `ninja` in
the `third_party/llvm-build/Release+Asserts` directory. In particular,
recompiling solely the tool you are writing can be accomplished by executing
`ninja rewrite_to_chrome_style` (replace `rewrite_to_chrome_style` with your
tool''s name).

## Running
First, build all Chromium targets to avoid failures due to missing dependencies
that are generated as part of the build:

```shell
ninja -C out/Debug  # For non-Windows
ninja -d keeprsp -C out/Debug  # For Windows

# experimental alternative:
$gen_targets = $(ninja -C out/Debug -t targets all \
                 | grep ''^gen/[^: ]*\.[ch][pc]*:'' \
                 | cut -f 1 -d :)
ninja -C out/Debug $gen_targets
```

Note that running the clang tool with precompiled headers enabled currently
produces errors. This can be avoided by setting
`enable_precompiled_headers = false` in the build''s gn args.

Then run the actual clang tool to generate a list of edits:

```shell
tools/clang/scripts/run_tool.py --tool <path to tool> \
  --generate-compdb
  -p out/Debug <path 1> <path 2> ... >/tmp/list-of-edits.debug
```

`--generate-compdb` can be omitted if the compile DB was already generated and
the list of build flags and source files has not changed since generation.

If cross-compiling, specify `--target_os`. See `gn help target_os` for
possible values. For example, when cross-compiling a Windows build on
Linux/Mac, use `--target_os=win`.

`<path 1>`, `<path 2>`, etc are optional arguments to filter the files to run
the tool against. This is helpful when sharding global refactorings into smaller
chunks. For example, the following command will run the `empty_string` tool
against just the `.c`, `.cc`, `.cpp`, `.m`, `.mm` files in `//net`.  Note that
the filtering is not applied to the *output* of the tool - the tool can emit
edits that apply to files outside of `//net` (i.e. edits that apply to headers
from `//base` that got included by source files in `//net`).

```shell
tools/clang/scripts/run_tool.py --tool empty_string  \
  --generate-compdb \
  -p out/Debug net >/tmp/list-of-edits.debug
```

Note that some header files might only be included from generated files (e.g.
from only from some `.cpp` files under out/Debug/gen).  To make sure that
contents of such header files are processed by the clang tool, the clang tool
needs to be run against the generated files.  The only way to accomplish this
today is to pass `--all` switch to `run_tool.py` - this will run the clang tool
against all the sources from the compilation database.

Finally, apply the edits as follows:

```shell
cat /tmp/list-of-edits.debug \
  | tools/clang/scripts/extract_edits.py \
  | tools/clang/scripts/apply_edits.py -p out/Debug <path 1> <path 2> ...
```

The apply_edits.py tool will only apply edits to files actually under control of
`git`.  `<path 1>`, `<path 2>`, etc are optional arguments to further filter the
files that the edits are applied to.  Note that semantics of these filters is
distinctly different from the arguments of `run_tool.py` filters - one set of
filters controls which files are edited, the other set of filters controls which
files the clang tool is run against.

## Debugging
Dumping the AST for a file:

```shell
clang++ -Xclang -ast-dump -std=c++14 foo.cc | less -R
```

Using `clang-query` to dynamically test matchers (requires checking out
and building [clang-tools-extra][]):

```shell
clang-query -p path/to/compdb base/memory/ref_counted.cc
```

`printf` debugging:

```c++
  clang::Decl* decl = result.Nodes.getNodeAs<clang::Decl>("decl");
  decl->dumpColor();
  clang::Stmt* stmt = result.Nodes.getNodeAs<clang::Stmt>("stmt");
  stmt->dumpColor();
```

By default, the script hides the output of the tool. The easiest way to change
that is to `return 1` from the `main()` function of the clang tool.

## Testing
Synposis:

```shell
tools/clang/scripts/test_tool.py <tool name> [--apply-edits]
```

The name of the tool binary and the subdirectory for the tool in
`//tools/clang` must match. The test runner finds all files that match the
pattern `//tools/clang/<tool name>/tests/*-original.cc`, and runs the tool
across those files.
If `--apply-edits` switch is presented, tool outputs are applied to respective
files and compared to the `*-expected.cc` version. If there is a mismatch, the
result is saved in `*-actual.cc`.
When `--apply-edits` switch is not presented, tool outputs are compared to
`*-expected.txt` and if different, the result is saved in `*-actual.txt`. Note
that in this case, only one test file is expected.

[//tools/clang]: https://chromium.googlesource.com/chromium/src/+/main/tools/clang/
[clang-docs-match-finder]: http://clang.llvm.org/doxygen/classclang_1_1ast__matchers_1_1MatchFinder.html
[clang-docs-match-callback]: http://clang.llvm.org/doxygen/classclang_1_1ast__matchers_1_1MatchFinder_1_1MatchCallback.html
[matcher-reference]: http://clang.llvm.org/docs/LibASTMatchersReference.html
[clang-docs-clang-tool-run]: http://clang.llvm.org/doxygen/classclang_1_1tooling_1_1ClangTool.html#acec91f63b45ac7ee2d6c94cb9c10dab3
[clang-docs-replacement]: http://clang.llvm.org/doxygen/classclang_1_1tooling_1_1Replacement.html
[clang-docs]: http://clang.llvm.org/doxygen/index.html
[clang-tooling-tutorial]: http://clang.llvm.org/docs/LibASTMatchersTutorial.html
[//tools/clang/blink_gc_plugin]: https://chromium.googlesource.com/chromium/src/+/main/tools/clang/blink_gc_plugin/
[//tools/clang/plugins]: https://chromium.googlesource.com/chromium/src/+/main/tools/clang/plugins/
[//tools/clang/rewrite_to_chrome_style]: https://chromium.googlesource.com/chromium/src/+/main/tools/clang/rewrite_to_chrome_style/
[clang-tools-extra]: (https://github.com/llvm-mirror/clang-tools-extra)
', NULL, N'development', N'development/clang_tool_refactoring', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Code Coverage', N'# The Clang Code Coverage Wrapper

The Clang code coverage wrapper
([//build/toolchain/clang_code_coverage_wrapper.py]) is a compiler wrapper that
adds code coverage flags to the invocations of Clang C/C++ compiler, which can
be used to instrument and generate code coverage data for a subset of the source
files. The main use case of this wrapper is to generate code coverage reports
for changed files at a per-CL level during try jobs.

One might ask: why this compiler wrapper instead of just instrumenting all the
source files?

Efficiency is the main consideration because comparing to instrument everything,
only instrument what-is-needed takes less time to build the test targets,
produces binaries that are 10 times smaller, run tests twice faster and
generates coverage reports significantly faster. An experiment was done to
evaluate the effectiveness of instrument what-is-needed, and in the experiment,
`unit_tests` is used as the sample test target and 8 randomly chosen C++ source
files are used as the samples files to instrument. The results are presented in
the following table:

| Type               | Build time | Binary size | Tests run time | Reports generation time |
|--------------------|------------|-------------|----------------|-------------------------|
| No instrumentation | 43m        | 240M        | 40s            | 0s                      |
| What-is-needed     | 43m        | 241M        | 40s            | 0.14s                   |
| Everything         | 53m        | 2.3G        | 80s            | 1m10s                   |

It can be seen from the results that the overhead introduced by instrument
everything is huge, while it''s negligible for instrument what-is-needed.

## How to use the coverage wrapper?
To get the coverage wrapper hook into your build, add the following flags to
your `args.gn` file, assuming build directory is `out/Release`.

```
use_clang_coverage = true
coverage_instrumentation_input_file = "//out/Release/coverage_instrumentation_input.txt"
```

The path to the coverage instrumentation input file should be a source root
absolute path, and the file consists of multiple lines where each line
represents a path to a source file, and the specified paths must be relative to
the root build directory. e.g. `../../base/task/post_task.cc` for build
directory `out/Release`.

Then, use the [//tools/code_coverage/coverage.py] script to build, run tests and
generate code coverage reports for the exercised files.

## Caveats
One caveat with this compiler wrapper is that it may introduce unexpected
behaviors in incremental builds when the file path to the coverage
instrumentation input file changes between consecutive runs, and the reason is
that the coverage instrumentation input file is explicitly passed to the
coverage wrapper as a command-line argument, which makes the path part of the
Ninja commands used to compile the source files, so change of the path between
consecutive runs causes Ninja to perform a full rebuild.

Due to the reasons mentioned above, users of this script are strongly advised to
always use the same path such as
`${root_build_dir}/coverage_instrumentation_input.txt`.

## Want to learn more about code coverage in Chromium?
For more background information on how code coverage works in Chromium, please
refer to [code_coverage.md]

## Contacts

### Reporting problems
We''re still evaluating the tools, for any breakage report and feature requests,
please [file a bug].

### Mailing list
For questions and general discussions, please join [code-coverage group].

[//build/toolchain/clang_code_coverage_wrapper.py]: ../build/toolchain/clang_code_coverage_wrapper.py
[code_coverage.md]: testing/code_coverage.md
[//tools/code_coverage/coverage.py]: ../tools/code_coverage/coverage.py
[file a bug]: https://bugs.chromium.org/p/chromium/issues/entry?components=Infra%3ETest%3ECodeCoverage
[code-coverage group]: https://groups.google.com/a/chromium.org/forum/#!forum/code-coverage
', NULL, N'development', N'development/clang_code_coverage_wrapper', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Rust in Chromium', N'# Rust in Chromium

[TOC]

# Why?

Handling untrustworthy data in non-trivial ways is a major source of security
bugs, and it''s therefore against Chromium''s security policies
[to do it in the Browser or Gpu process](../docs/security/rule-of-2.md) unless
you are working in a memory-safe language.

Rust provides a cross-platform memory-safe language so that all platforms can
handle untrustworthy data directly from a privileged process, without the
performance overheads and complexity of a utility process.

# Status

The Rust toolchain is enabled for and supports all platforms and development
environments that are supported by the Chromium project. The first milestone
to include full production-ready support was M119.

Rust can be used anywhere in the Chromium repository (not just `//third_party`)
subject to [current interop capabilities][interop-rust-doc], however it is
currently subject to a internal approval and FYI process. Googlers can view
go/chrome-rust for details. New usages of Rust are documented at
[`rust-fyi@chromium.org`](https://groups.google.com/a/chromium.org/g/rust-fyi).

For questions or help, reach out to `rust-dev@chromium.org` or `#rust` on the
[Chromium Slack](https://www.chromium.org/developers/slack/).

If you use VSCode, we have [additional advice below](#using-vscode).

# Adding a third-party Rust library

Third-party libraries are pulled from [crates.io](https://crates.io), but
Chromium does not use Cargo as a build system.

## Third-party review

All third-party crates need to go through third-party review. See
[//docs/adding_to_third_party.md](adding_to_third_party.md) for instructions on
how to have a library reviewed.

## Importing a crate from crates.io

The `//third_party/rust/chromium_crates_io/Cargo.toml` file defines the set of crates
depended on from first-party code. Any transitive dependencies will be found
from those listed there. The file is a [standard `Cargo.toml` file](
https://doc.rust-lang.org/cargo/reference/manifest.html), though the crate
itself is never built, it is only used to collect dependencies through the
`[dependencies]` section.

To use a third-party crate "bar" version 3 from first party code:
1. Change directory to the root `src/` dir of Chromium.
1. Add the crate to `//third_party/rust/chromium_crates_io/Cargo.toml`:
   * `vpython3 ./tools/crates/run_gnrt.py add foo` to add the latest version of `foo`.
   * `vpython3 ./tools/crates/run_gnrt.py add foo@1.2.3` to add a specific version of `foo`.
   * Or, directly through (nightly) cargo:
     `cargo run --release --manifest-path tools/crates/gnrt/Cargo.toml --target-dir out/gnrt add foo`
   * Or, edit the Cargo.toml by hand, finding the version you want from [crates.io](https://crates.io).
1. Download the crate''s files:
   * `./tools/crates/run_gnrt.py vendor` to download the new crate.
   * Or, directly through (nightly) cargo:
     `cargo run --release --manifest-path tools/crates/gnrt/Cargo.toml --target-dir out/gnrt vendor`
   * This will also apply any patches in `//third_party/rust/chromium_crates_io/patches`
     for the crates. If a patch can not apply, the crate''s download will be cancelled and
     an error will be printed. See [patching errors](#patching-errors) below for how to resolve
     this.
1. (optional) If the crate is only to be used by tests and tooling, then
   specify the `"test"` group in `//third_party/rust/chromium_crates_io/gnrt_config.toml`:
   ```
   [crate.foo]
   group = "test"
   ```
1. Generate the `BUILD.gn` file for the new crate:
   * `vpython3 ./tools/crates/run_gnrt.py gen`
   * Or, directly through (nightly) cargo:
     `cargo run --release --manifest-path tools/crates/gnrt/Cargo.toml --target-dir out/gnrt gen`
1. Verify if all new dependencies are already audited by running `cargo vet`
   See [`rust-unsafe.md#cargo-vet-policy`](rust-unsafe.md#cargo-vet-policy) for
   more details.  This boils down to:
   * `./tools/crates/run_cargo_vet.py check`
   * If `check` fails, then there are missing audits, which need to be added to
     `//third_party/rust/chromium_crates_io/supply-chain/audits.toml`.
1. Add the new files to git:
   * `git add -f third_party/rust/chromium_crates_io/vendor`.
     (The `-f` is important, as files may be skipped otherwise from a
     `.gitignore` inside the crate.)
   * `git add third_party/rust`
1. Upload the CL. If there is any `unsafe` usage then Security experts will need to
   audit the "ub-risk" level.  See
   [`rust-unsafe.md#code-review-policy`](rust-unsafe.md#code-review-policy) for
   more details.

### Cargo features

To enable a feature "spaceships" in the crate, change the entry in
`//third_party/rust/chromium_crates_io/Cargo.toml` to include the feature:
```toml
[dependencies]
bar = { version = "3", features = [ "spaceships" ] }
```

### Patching third-party crates

You may patch a crate in tree, but save any changes made into a diff file in
a `//third_party/rust/chromium_crates_io/patches/` directory for the crate.
The diff file should be generated by `git-format-patch` each new patch numbered
consecutively so that they can be applied in order. For example, these files
might exist if the "foo" crate was patched with a couple of changes:

```
//third_party/rust/chromium_crates_io/patches/foo/patches/0001-Edit-the-Cargo-toml.diff
//third_party/rust/chromium_crates_io/patches/foo/patches/0002-Other-changes.diff
```

The recommended procedure to create such patches is:

1. Commit the plain new version of the crate to your local git branch
2. Modify the crate as necessary
3. Commit that modified version
4. Use `git format-patch <unpatched version>` to generate the patch files
5. Add the patch files in a new, third, commit
6. Squash them, or rely on `git cl upload` doing so

#### Patching errors

If `gnrt vendor` fails to apply a patch for a crate, it will cancel the download of that
crate rather than leave it in a broken state. To recreate patches, first get a pristine
copy of the crate by using the `--no-patches` argument:

1. Download the crate without applying patches:
   * `vpython3 ./tools/crates/run_gnrt.py vendor --no-patches=<CRATE_NAME>`
2. Then recreate the patches as described in [Patching third-party crates](
   #patching-third_party-crates).

To verify the patches work, remove the vendored crate directory in
`//third_party/rust/chromium_crates_io/vendor/`, named after the crate name
and version. Then run the `vendor` action without `--no-patches` which will
download the crate and apply the patches:
   * `vpython3 ./tools/crates/run_gnrt.py vendor`

## Security

If a shipping library needs security review (has any `unsafe`), and the review
finds it''s not satisfying the [rule of 2](../docs/security/rule-of-2.md), then
move it to the `"sandbox"` group in `//third_party/rust/chromium_crates_io/gnrt_config.toml`
to make it clear it can''t be used in a privileged process:
```
[crate.foo]
group = "sandbox"
```

If a transitive dependency moves from `"safe"` to `"sandbox"` and causes
a dependency chain across the groups, it will break the `gnrt vendor` step.
You will need to fix the new crate so that it''s deemed safe in unsafe review,
or move the other dependent crates out of `"safe"` as well by setting their
group in `gnrt_config.toml`.

# Updating existing third-party crates

Third-party crates will get updated semi-automatically through the process
described in
[`../tools/crates/create_update_cl.md`](../tools/crates/create_update_cl.md).
If you nevertheless need to manually update a crate to its latest minor
version, then follow the steps below:

1. Change directory to the root `src/` dir of Chromium.
1. Update the versions in `//third_party/rust/chromium_crates_io/Cargo.toml`.
   * `vpython3 ./tools/crates/run_gnrt.py update <crate name>`
   * Or, directly through (nightly) cargo:
     `cargo run --release --manifest-path tools/crates/gnrt/Cargo.toml --target-dir out/gnrt update <crate name>`
1. Download any updated crate''s files:
   * `./tools/crates/run_gnrt.py vendor`
   * If you want to restrict the update to certain crates, add the crate names
     as arguments to `vendor`, like: `./tools/crates/run_gnrt.py vendor
     <crate-name>`
   * Or, directly through (nightly) cargo:
     `cargo run --release --manifest-path tools/crates/gnrt/Cargo.toml --target-dir out/gnrt vendor`
1. Add the downloaded files to git:
   * `git add -f third_party/rust/chromium_crates_io/vendor`
   * The `-f` is important, as files may be skipped otherwise from a
     `.gitignore` inside the crate.
1. Generate the `BUILD.gn` files
   * `vpython3 ./tools/crates/run_gnrt.py gen`
   * Or, directly through (nightly) cargo:
     `cargo run --release --manifest-path tools/crates/gnrt/Cargo.toml --target-dir out/gnrt gen`
1. Add the generated files to git:
   * `git add -f third_party/rust`

### Directory structure for third-party crates

The directory structure for a crate "foo" version 3.4.2 is:
```
//third_party/
    rust/
        foo/  (for the "foo" crate)
            v3/  (version 3.4.2 maps to the v3 epoch)
                BUILD.gn  (generated by gnrt gen)
                README.chromium  (generated by gnrt vendor)
        chromium_crates_io/
            vendor/
                foo-3.4.2  (crate sources downloaded from crates.io)
            patches/
                foo/  (patches for the "foo" crate)
                    0001-Edit-the-Cargo-toml.diff
                    0002-Other-changes.diff
            Cargo.toml
            Cargo.lock
            gnrt_config.toml
```

## Writing a wrapper for binding generation

Most Rust libraries will need a more C++-friendly API written on top of them in
order to generate C++ bindings to them. The wrapper library can be placed
in `//third_party/rust/<cratename>/<epoch>/wrapper` or at another single place
that all C++ goes through to access the library. The [CXX](https://cxx.rs) is
used to generate bindings between C++ and Rust.

See
[`//third_party/rust/serde_json_lenient/v0_1/wrapper/`](
https://source.chromium.org/chromium/chromium/src/+/main:third_party/rust/serde_json_lenient/v0_1/wrapper/)
and
[`//components/qr_code_generator`](
https://source.chromium.org/chromium/chromium/src/+/main:components/qr_code_generator/;l=1;drc=b185db5d502d4995627e09d62c6934590031a5f2)
for examples.

Rust libraries should use the
[`rust_static_library`](
https://source.chromium.org/chromium/chromium/src/+/main:build/rust/rust_static_library.gni)
GN template (not the built-in `rust_library`) to integrate properly into the
mixed-language Chromium build and get the correct compiler options applied to
them.

The [CXX](https://cxx.rs) tool is used for generating C++ bindings to Rust
code. Since it requires explicit declarations in Rust, an wrapper shim around a
pure Rust library is needed. Add these Rust shims that contain the CXX
`bridge` macro to the `cxx_bindings` GN variable in the `rust_static_library`
to have CXX generate a C++ header for that file. To include the C++ header
file, rooted in the `gen` output directory, use
```
#include "the/path/to/the/rust/file.rs.h"
```

# Logging

Use the [log](https://docs.rs/log) crate''s macros in place of base `LOG`
macros from C++. They do the same things. The `debug!` macro maps to
`DLOG(INFO)`, the `info!` macro maps to `LOG(INFO)`, and `warn!` and `error!`
map to `LOG(WARNING)` and `LOG(ERROR)` respectively. The additional `trace!`
macro maps to `DLOG(INFO)` (but there is [WIP to map it to `DVLOG(INFO)`](
https://chromium-review.googlesource.com/c/chromium/src/+/5996820)).

Note that the standard library also includes a helpful
[`dbg!`](https://doc.rust-lang.org/std/macro.dbg.html) macro which writes
everything about a variable to `stderr`.

Logging may not yet work in component builds:
[crbug.com/374023535](https://crbug.com/374023535).

# Tracing

TODO: [crbug.com/377915495](https://crbug.com/377915495).

# Strings

Prefer to use [`BString`](https://docs.rs/bstr/latest/bstr/struct.BString.html)
and [`BStr`](https://docs.rs/bstr/latest/bstr/struct.BStr.html) to work with
strings in first-party code instead of `std::String` and `str`. These types do
not require the strings to be valid UTF-8, and avoid error handling or panic
crashes when working with strings from C++ and/or from the web. Because the
web is not UTF-8 encoded, many strings in Chromium are also not.

In cross-language bindings, `&[u8]` can be used to represent a string until
native support for `BStr` is available in our interop tooling. A `u8` slice
can be converted to `BStr` or treated as a string with
[`ByteSlice`](https://docs.rs/bstr/latest/bstr/trait.ByteSlice.html).

# Using VSCode

1. Ensure you''re using the `rust-analyzer` extension for VSCode, rather than
   earlier forms of Rust support.
2. Run `gn` with the `--export-rust-project` flag, such as:
   `gn gen out/Release --export-rust-project`.
3. `ln -s out/Release/rust-project.json rust-project.json`
4. When you run VSCode, or any other IDE that uses
   [rust-analyzer](https://rust-analyzer.github.io/) it should detect the
   `rust-project.json` and use this to give you rich browsing, autocompletion,
   type annotations etc. for all the Rust within the Chromium codebase.
5. Point rust-analyzer to the rust toolchain in Chromium. Otherwise you will
   need to install Rustc in your system, and Chromium uses the nightly
   compiler, so you would need that to match. Add the following to
   `.vscode/settings.json` in the Chromium checkout:
   ```
   {
      // The rest of the settings...

      "rust-analyzer.cargo.extraEnv": {
        "PATH": "../../third_party/rust-toolchain/bin:$PATH",
      }
   }
   ```
   This assumes you are working with an output directory like `out/Debug` which
   has two levels; adjust the number of `..` in the path according to your own
   setup.

# Using cargo

If you are building a throwaway or experimental tool, you might like to use pure
`cargo` tooling rather than `gn` and `ninja`. Even then, you may choose
to restrict yourself to the toolchain and crates that are already approved for
use in Chromium.

Here''s how.

```
export PATH_TO_CHROMIUM_SRC=~/chromium/src
mkdir my-rust-tool
cd my-rust-tool
mkdir .cargo
cat <<END > .cargo/config.toml
[source.crates-io]
replace-with = "vendored-sources"

[source.vendored-sources]
directory = "$PATH_TO_CHROMIUM_SRC/third_party/rust/chromium_crates_io/vendor"
END
$PATH_TO_CHROMIUM_SRC/third_party/rust-toolchain/bin/cargo init --offline
$PATH_TO_CHROMIUM_SRC/third_party/rust-toolchain/bin/cargo run --offline
```

Most `cargo` tooling works well with this setup; one exception is `cargo add`,
but you can still add dependencies manually to your `Cargo.toml`:

```
[dependencies]
log = "0.4"
```

[interop-rust-doc]: https://docs.google.com/document/d/1kvgaVMB_isELyDQ4nbMJYWrqrmL3UZI4tDxnyxy9RTE/edit?tab=t.0#heading=h.fpqr6hf3c3j0
', NULL, N'development', N'development/rust', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Rust Unsafe Guidelines', N'# `unsafe` Rust Guidelines

## Code Review Policy {#code-review-policy}

All `unsafe` Rust code in Chromium needs to be reviewed and LGTM-ed by a member
of the `unsafe-rust-in-chrome@google.com` group and the review must be cc''d to
the group for visibility.  This policy applies to both third-party code
(e.g. under `//third_party/rust`) and first-party code.

### How to request a review

To facilitate a code review please:

* For each new or modified `unsafe` block, function, `impl`, etc.,
  add an unresolved "TODO: `unsafe` review" comment in Gerrit.
  You can consider using `tools/crates/create_draft_comments.py` to streamline
  creating such comments.

* Add `chrome-unsafe-rust-reviews@google.com` as a reviewer.

### Scope of review

Note that changes _anywhere_ in a crate that uses `unsafe` blocks may violate
the internal invariants on which those `unsafe` blocks rely. It is unrealistic
to require a `unsafe-rust-in-chrome@google.com` review to re-audit all the
`unsafe` blocks each time a crate is updated, but the crate `OWNERS` and other
reviewers should be on the lookout for code changes which feel as though they
could affect invariants on which `unsafe` blocks rely.

### `OWNERS` files guidance

To require `unsafe` review for certain `.rs` files
(e.g. ones that use `unsafe` Rust)
you can forward from the file''s `OWNERS` to
`//third_party/rust/UNSAFE_RUST_OWNERS`
(see comments in the latter for more details).

### Soft SLA

For incremental changes (including updating a minor version of a crate under
`//third_party/rust/chromium_crates_io`) the usual [Chromium responsiveness
expectations](cl_respect.md#expect-responsiveness) apply. (i.e. You should expect
reviewer input within 1 business day.)

For bulk changes (e.g. importing a new crate and its transitive dependencies)
the turnaround time may be longer.  This depends mostly on the amount of
`unsafe` code.  To streamline reviews and future maintainability, we ask you
kindly to prefer crates that do *not* use `unsafe` Rust code.

### Other notes

Bugs that track streamlining application of this policy are tracked under
the umbrella of https://crbug.com/393394872/dependencies.

## `cargo vet` Policy {#cargo-vet-policy}

Crates in `//third_party/rust/chromium_crates_io` need to be covered by `cargo
vet` audits.  In other words, `tools/crates/run_cargo_vet.py check` should
always succeed (this is enforced by `//third_party/rust/PRESUBMIT.py`).

### Audit criteria required for most crates

Audit criteria required for a given crate depend on how the crate is used.  The
criteria are written to
`third_party/rust/chromium_crates_io/supply-chain/config.toml` by
`tools/crates/run_gnrt.py vendor` based on whether
`third_party/rust/chromium_crates_io/gnrt_config.toml` declares that the crate
is meant to be used (maybe transitively) in a `safe`, `sandbox`, or `test`
environment.  For example, to declare that a crate is `safe` to be used in the
browser process, it needs to be audited and certified to be `safe-to-deploy`,
`ub-risk-2` or lower, and either `does-not-implement-crypto` or `crypto-safe`.

Note that some audits can be done by any engineer ("ub-risk-0" and
"safe-to-run") while others will require specialists from the
`unsafe-rust-in-chrome@google.com` group (see the ["Code Review Policy"
above](#code-review-policy).  More details about audit criteria and the required
expertise are explained in the
[auditing_standards.md](https://github.com/google/rust-crate-audits/blob/main/auditing_standards.md),
which also provides guidance for conducting delta audits.

### Some crates don''t require an audit

Chromium implicitly trusts certain crate publishers.  Currently
there are two scenarios where such trust relationship may be established:

* Trusting crates authored and maintained under https://github.com/rust-lang/
  (e.g. `libc`, `hashbrown`), because they are closely related to the Rust
  toolchain (i.e. the same group managed and publishes `rustc`,
  `rustfmt`, `cargo`, `rustup`, etc.).
* Trusting crates that are part of an OS SDK (e.g. `windows-...` crates).

Chromium uses both our own audits
(stored in `third_party/rust/chromium_crates_io/supply-chain/audits.toml`)
as well as audits imported from other parts of Google
(e.g. Android, Fuchsia, etc.).  This means that adding a new crate does not
necessarily require a new audit if the crate has already been audited by
other projects (in this case, `cargo vet` will record the imported audit
in the `third_party/rust/chromium_crates_io/supply-chain/imports.lock` file).

### How to run `cargo vet` in Chromium

See
[Cargo Vet documentation](https://mozilla.github.io/cargo-vet/recording-audits.html)
for how to record the audit in `audits.toml`.
The `tools/crates/run_cargo_vet.py` may be used to invoke Chromium''s copy of
`cargo-vet`.

', NULL, N'development', N'development/rust-unsafe', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Clang Gardening', N'# Clang Gardening

Chromium bundles its own pre-built version of [Clang](clang.md). This is done so
that Chromium developers have access to the latest and greatest developer tools
provided by Clang and LLVM (ASan, CFI, coverage, etc). In order to [update the
compiler](updating_clang.md) (roll clang), it has to be tested so that we can be
confident that it works in the configurations that Chromium cares about.

We maintain a [waterfall of
builders](https://ci.chromium.org/p/chromium/g/chromium.clang/console) that
continuously build fresh versions of Clang and use them to build and test
Chromium. "Clang gardening" is the process of monitoring that waterfall,
determining if any compile or test failures are due to an upstream compiler
change, filing bugs upstream, and often reverting bad changes in LLVM. This
document describes some of the processes and techniques for doing that.

Some may find the
[sheriff-o-matic](https://sheriff-o-matic.appspot.com/chromium.clang)
view of the waterfall easier to work with.

To keep others informed, [file a
bug](https://bugs.chromium.org/p/chromium/issues/entry).
earlier rather than later for build breaks likely caused by changes in
clang or the rest fo the toolchain. Make sure to set the component field to
`Tools > LLVM`, which will include the entire Chrome toolchain (Lexan) team.

At the beginning of your gardener rotation, it may be
useful to [search for recent bot
breaks](https://bugs.chromium.org/p/chromium/issues/list?q=component%3ATools%3ELLVM&can=2&sort=-modified).
We prefer searching like this to having gardeners compose status email at the
end of their week.

In addition to the waterfall, make sure
[dry run attempts at updating clang](https://chromium-review.googlesource.com/q/path:tools/clang/scripts/update.py)
are green. As part of the Clang release process we run upstream LLVM tests.
Ideally these tests are covered by upstream LLVM bots and breakages are
quickly noticed and fixed by the original author of a breaking commit,
but that is sadly not always the case.

Each gardener should attempt to update the compiler by performing
[a Clang roll](updating_clang.md) during their week, assuming the bots are
green enough.

The gardener is also responsible for taking notes during the weekly Chrome toolchain
(Lexan) status sync-up meeting.

[TOC]

## Disk out of space

If there are any issues with disk running out of space, file a go/bug-a-trooper
bug, for example https://crbug.com/1105134.

## Is it the compiler?

Chromium does not always build and pass tests in all configurations that
everyone cares about. Some configurations simply take too long to build
(ThinLTO) or be tested (dbg) on the CQ before committing. And, some tests are
flaky. So, our console is often filled with red boxes, and the boxes don''t
always need to be green to roll clang.

Oftentimes, if a bot is red with a test failure, it''s not a bug in the compiler.
To check this, the easiest and best thing to do is to try to find a
corresponding builder that doesn''t use ToT clang. For standard configurations,
start on the waterfall that corresponds to the OS of the red bot, and search
from there. If the failing bot is Google Chrome branded, go to the (Google
internal) [official builder
list](https://uberchromegw.corp.google.com/i/official.desktop.continuous/builders/)
and start searching from there.

If you are feeling charitable, you can try to see when the test failure was
introduced by looking at the history in the bot. One way to do this is to add
`?numbuilds=200` to the builder URL to see more history. If that isn''t enough
history, you can manually binary search build numbers by editing the URL until
you find where the regression was introduced. If it''s immediately clear what CL
introduced the regression (i.e.  caused tests to fail reliably in the official
build configuration), you can simply load the change in gerrit and revert it,
linking to the first failing build that implicates the change being reverted.

If the failure looks like a compiler bug, these are the common failures we see
and what to do about them:

1. compiler crash
1. compiler warning change
1. compiler error
1. miscompile
1. linker errors

## Compiler crash

This is probably the most common bug. The standard procedure is to do these
things:

1. Open the `gclient runhooks` stdout log from the first red build.  Near the
   top of that log you can find the range of upstream llvm revisions.  For
   example:

       From https://github.com/llvm/llvm-project
           f917356f9ce..292e898c16d  master     -> origin/master

1. File a crbug documenting the crash. Include the range, and any other bots
   displaying the same symptoms.
1. All clang crashes on the Chromium bots are automatically uploaded to
   Cloud Storage. On the failing build, click the "stdout" link of the
   "process clang crashes" step right after the red compile step. It will
   print something like

       processing heap_page-65b34d... compressing... uploading... done
           gs://chrome-clang-crash-reports/v1/2019/08/27/chromium.clang-ToTMac-20955-heap_page-65b34d.tgz
       removing heap_page-65b34d.sh
       removing heap_page-65b34d.cpp

   Use
   `gsutil.py cp gs://chrome-clang-crash-reports/v1/2019/08/27/chromium.clang-ToTMac-20955-heap_page-65b34d.tgz .`
   to copy it to your local machine. Untar with
   `tar xzf chromium.clang-ToTMac-20955-heap_page-65b34d.tgz` and change the
   included shell script to point to a locally-built clang. Remove the
   `-Xclang -plugin` flags.  If you re-run the shell script, it should
   reproduce the crash.
1. Identify the revision that introduced the crash. First, look at the commit
   messages in the LLVM revision range to see if one modifies the code near the
   point of the crash. If so, try reverting it locally, rebuild, and run the
   reproducer to see if the crash goes away.

   If that doesn''t work, use `git bisect`. Use this as a template for the bisect
   run script:
   ```shell
   #!/bin/bash
   cd $(dirname $0)  # get into llvm build dir
   ninja -j900 clang || exit 125 # skip revisions that don''t compile
   ./t-8f292b.sh || exit 1  # exit 0 if good, 1 if bad
   ```
1. File an upstream bug like http://llvm.org/PR43016. Usually the unminimized repro
   is too large for LLVM''s bugzilla, so attach it to a (public) crbug and link
   to that from the LLVM bug. Then revert with a commit message like
   "Revert r368987, it caused PR43016."
1. If you want, make a reduced repro using CReduce.  Clang contains a handy wrapper around
   CReduce that you can invoke like so:

       clang/utils/creduce-clang-crash.py --llvm-bin bin \
           angle_deqp_gtest-d421b0.sh angle_deqp_gtest-d421b0.cpp

   Attach the reproducer to the llvm bug you filed in the previous step. You can
   disable Creduce''s renaming passes with the options
   `--remove-pass pass_clang rename-fun --remove-pass pass_clang rename-param
   --remove-pass pass_clang rename-var --remove-pass pass_clang rename-class
   --remove-pass pass_clang rename-cxx-method --remove-pass pass_clex
   rename-toks` which makes it easier for the author to reason about and to
   further reduce it manually.

   If you need to do something the wrapper doesn''t support,
   follow the [official CReduce docs](https://embed.cs.utah.edu/creduce/using/)
   for writing an interestingness test and use creduce directly.

## Compiler warning change

New Clang versions often find new bad code patterns to warn on. Chromium builds
with `-Werror`, so improvements to warnings often turn into build failures in
Chromium. Once you understand the code pattern Clang is complaining about, file
a bug to do either fix or silence the new warning.

If this is a completely new warning, disable it by adding `-Wno-NEW-WARNING` to
[this list of disabled
warnings](https://cs.chromium.org/chromium/src/build/config/compiler/BUILD.gn?l=1479)
if `llvm_force_head_revision` is true. Here is [an
example](https://chromium-review.googlesource.com/1251622). This will keep the
ToT bots green while you decide what to do.

Sometimes, behavior changes and a pre-existing warning changes to warn on new
code. In this case, fixing Chromium may be the easiest and quickest fix. If
there are many sites, you may consider changing clang to put the new diagnostic
into a new warning group so you can handle it as a new warning as described
above.

If the warning is high value, then eventually our team or other contributors
will end up fixing the crbug and there is nothing more to do.  If the warning
seems low value, pass that feedback along to the author of the new warning
upstream. It''s unlikely that it should be on by default or enabled by `-Wall` if
users don''t find it valuable. If the warning is particularly noisy and can''t be
easily disabled without disabling other high value warnings, you should consider
reverting the change upstream and asking for more discussion.

## Compiler error

This rarely happens, but sometimes clang becomes more strict and no longer
accepts code that it previously did. The standard procedure for a new warning
may apply, but it''s more likely that the upstream Clang change should be
reverted, if the C++ code in question in Chromium looks valid.

## Miscompile

Miscompiles tend to result in crashes, so if you see a test with the CRASHED
status, this is probably what you want to do.

1. Bisect object files to find the object with the code that changed. LLVM
   contains `llvm/utils/rsp_bisect.py` which may be useful for bisecting object
   files using an rsp file.
1. Debug it with a traditional debugger

## Linker error

`ld.lld`''s `--reproduce` flag makes LLD write a tar archive of all its inputs
and a file `response.txt` that contains the link command. This allows people to
work on linker bugs without having to have a Chromium build environment.

To use `ld.lld`''s `--reproduce` flag, follow these steps:

1. Locally (build Chromium with a locally-built
   clang)[https://chromium.googlesource.com/chromium/src.git/+/main/docs/clang.md#Using-a-custom-clang-binary]

1. After reproducing the link error, build just the failing target with
   ninja''s `-v -d keeprsp` flags added:
  `ninja -C out/gn base_unittests -v -d keeprsp`.

1. Copy the link command that ninja prints, `cd out/gn`, paste it, and manually
   append `-Wl,--reproduce,repro.tar`. With `lld-link`, instead append
   `/reproduce:repro.tar`. (`ld.lld` is invoked through the `clang` driver, so
   it needs `-Wl` to pass the flag through to the linker. `lld-link` is called
   directly, so the flag needs no prefix.)

1. Zip up the tar file: `gzip repro.tar`. This will take a few minutes and
   produce a .tar.gz file that''s 0.5-1 GB.

1. Upload the .tar.gz to Google Drive. If you''re signed in with your @google
   address, you won''t be able to make a world-shareable link to it, so upload
   it in a Window where you''re signed in with your @chromium account.

1. File an LLVM bug linking to the file. Example: http://llvm.org/PR43241

TODO: Describe object file bisection, identify obj with symbol that no longer
has the section.

## ThinLTO Trouble

Sometimes, problems occur in ThinLTO builds that do not occur in non-LTO builds.
These steps can be used to debug such problems.

Notes:

 - All steps assume they are run from the output directory (the same directory args.gn is in).

 - Commands have been shortened for clarity. In particular, Chromium build commands are
   generally long, with many parts that you just copy-paste when debugging. These have
   largely been omitted.

 - The commands below use "clang++", where in practice there would be some path prefix
   in front of this. Make sure you are invoking the right clang++. In particular, there
   may be one in the PATH which behaves very differently.

### Get the full command that is used for linking

To get the command that is used to link base_unittests:

```sh
$ rm base_unittests
$ ninja -n -d keeprsp -v base_unittests
```

This will print a command line. It will also write a file called `base_unittests.rsp`, which
contains additional parameters to be passed.

### Remove ThinLTO cache flags

ThinLTO uses a cache to avoid compilation in some cases. This can be confusing
when debugging, so make sure to remove the various cache flags like
`-Wl,--thinlto-cache-dir`.

### Expand Thin Archives on Command Line

Expand thin archives mentioned in the command line to their individual object files.
The script `tools/clang/scripts/expand_thin_archives.py` can be used for this purpose.
For example:

```sh
$ ../../tools/clang/scripts/expand_thin_archives.py -p=-Wl, -- @base_unittests.rsp > base_unittests.expanded.rsp
```

The `-p` parameter here specifies the prefix for parameters to be passed to the linker.
If you are invoking the linker directly (as opposed to through clang++), the prefix should
be empty.

```sh
$ ../../tools/clang/scripts/expand_thin_archives.py -p='''', -- @base_unittests.rsp > base_unittests.expanded.rsp
```

### Remove -Wl,--start-group and -Wl,--end-group

Edit the link command to use the expanded command line, and remove any mention of `-Wl,--start-group`
and `-Wl,--end-group` that surround the expanded command line. For example, if the original command was:

    clang++ -fuse-ld=lld -o ./base_unittests -Wl,--start-group @base_unittests.rsp -Wl,--end-group

the new command should be:

    clang++ -fuse-ld=lld -o ./base_unittests @base_unittests.expanded.rsp

The reason for this is that the `-start-lib` and `-end-lib` flags that expanding the command
line produces cannot be nested inside `--start-group` and `--end-group`.

### Producing ThinLTO Bitcode Files

In a ThinLTO build, what is normally the compile step that produces native object files
instead produces LLVM bitcode files. A simple example would be:

```sh
$ clang++ -c -flto=thin foo.cpp -o foo.o
```

In a Chromium build, these files reside under `obj/`, and you can generate them using ninja.
For example:

```sh
$ ninja obj/base/base/lock.o
```

These can be fed to `llvm-dis` to produce textual LLVM IR:
   
```
$ llvm-dis -o - obj/base/base/lock.o | less
```

When using split LTO unit (`-fsplit-lto-unit`, which is required for
some features, CFI among them), this may produce a message like:

    llvm-dis: error: Expected a single module

   In that case, you can use `llvm-modextract`:
   
```sh
$ llvm-modextract -n 0 -o - obj/base/base/lock.o | llvm-dis -o - | less
```

### Saving Intermediate Bitcode

The ThinLTO linking process proceeds in a number of stages. The bitcode that is
generated during these stages can be saved by passing `-save-temps` to the linker:

```
$ clang++ -fuse-ld=lld -Wl,-save-temps -o ./base_unittests @base_unittests.expanded.rsp
```

This generates files such as:
 - lock.o.0.preopt.bc
 - lock.o.3.import.bc
 - lock.o.5.precodegen.bc

in the directory where lock.o is (obj/base/base).

These can be fed to `llvm-dis` to produce textual LLVM IR. They show
how the code is transformed as it progresses through ThinLTO stages.
Of particular interest are:
 - .3.import.bc, which shows the IR after definitions have been imported from
   other modules, but before optimizations. Running this through LLVM''s `opt`
   tool with the right optimization level can often reproduce issues.
 - .5.precodegen.bc, which shows the IR just before it is transformed to native
   code. Running this through LLVM''s `llc` tool with the right optimization level
   can often reproduce issues.

The same `-save-temps` command also produces `base_unittests.resolution.txt`, which
shows symbol resolutions. These look like:

    -r=obj/base/test/run_all_base_unittests/run_all_base_unittests.o,main,plx

In this example, run_all_base_unittests.o contains a symbol named
main, with flags plx.
   
The possible flags are:
 - p: prevailing: of symbols with this name, this one has been chosen.
 - l: final definition in this linkage unit.
 - r: redefined by the linker.
 - x: visible to regular (that is, non-LTO) objects.

### Code Generation for a Single Module

To speed up debugging, it may be helpful to limit code generation to a single
module if you know the name of the module (e.g. the module name is in a crash
dump).

`-Wl,--thinlto-single-module=foo` tells ThinLTO to only run
optimizations/codegen on files matching the pattern and skip linking. This is
helpful especially in combination with `-Wl,-save-temps`.

```sh
$ clang++ -fuse-ld=lld -Wl,--thinlto-single-module=obj/base/base/lock.o -o ./base_unittests @base_unittests.expanded.rsp
```

You should see

```sh
[ThinLTO] Selecting obj/base/base/lock.o to compile
```

being printed.

## Tips and tricks

Finding what object files differ between two directories:

```
$ diff -u <(cd out.good && find . -name "*.o" -exec sha1sum {} \; | sort -k2) \
          <(cd out.bad  && find . -name "*.o" -exec sha1sum {} \; | sort -k2)
```

Or with cmp:

```
$ find good -name "*.o" -exec bash -c ''cmp -s $0 ${0/good/bad} || echo $0'' {} \;
```
', NULL, N'development', N'development/clang_gardening', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Clang Sheriffing', N'# Clang Sheriffing

See [Clang Gardening](clang_gardening.md).
', NULL, N'development', N'development/clang_sheriffing', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Testing in Chromium', N'Testing is an essential component of software development in Chromium,
it ensures Chrome is behaving as we expect, and is critical to find bugs and
regressions at early stage.

This document covers the high level overview of testing in Chromium,
including what type of tests we have, what''s the purpose for each test type,
what tests are needed for new features etc.

## Test Types

There are several different types of tests in Chromium to serve different purposes,
some types of test are running on multiple platforms, others are specific
for one platform.

*   **[gtest]** is Google''s C++ test framework,
    which helps you write better C++ tests in Chromium.
    gtest is test framework for unit tests in Chromium and browser tests are built on top of it.
*   **Browser Tests** is built on top of gtest, and it is used to write integration tests
    and e2e tests in Chromium.
    <!-- TODO(leilei) Add link to browser tests --->
*   **[Web Tests] (formerly known as "Layout Tests" or "LayoutTests")**
    is used by Blink to test many components, including but not
    limited to layout and rendering. In general, web tests involve loading pages
    in a test renderer (`content_shell`) and comparing the rendered output or
    JavaScript output against an expected output file.
    Web Tests are required to launch new W3C API support in Chromium.
*   **[Robolectric]** is build on top of JUnit 4. It emulates Android APIs so
    that tests can be run on the host machine instead of on devices / emulators.
*   **[Instrumentation Tests]** are JUnit tests that run on devices / emulators.
*   **[EarlGrey]** is the integration testing framework used by Chromium for iOS.
*   **[Telemetry]** is the performance testing framework used by Chromium.
    It allows you to perform arbitrary actions on a set of web pages and
    report metrics about it.
*   **[Fuzzer Tests]** is used to uncover potential security & stability problems in Chromium.
*   **[Tast]** is a test framework for system integration tests on Chrome OS.


The following table shows which types of test works on which platforms.

|                             |  Linux  | Windows |   Mac   | Android |  iOS    |  CrOS   |
|:----------------------------|:--------|:--------|:--------|:--------|:--------|:--------|
| gtest(C++)                  | &#8730; | &#8730; | &#8730; | &#8730; | &#8730; | &#8730; |
| Browser Tests(C++)          | &#8730; | &#8730; | &#8730; | &#8730; |         |         |
| Web Tests(HTML, JS)         | &#8730; | &#8730; | &#8730; |         |         |         |
| Telemetry(Python)           | &#8730; | &#8730; | &#8730; | &#8730; |         | &#8730; |
| Robolectric(Java)           |         |         |         | &#8730; |         |         |
| Instrumentation Tests(Java) |         |         |         | &#8730; |         |         |
| EarlGrey                    |         |         |         |         | &#8730; |         |
| Fuzzer Tests(C++)           | &#8730; | &#8730; | &#8730; | &#8730; |         | &#8730; |
| Tast(Golang)                |         |         |         |         |         | &#8730; |

*** note
**Browser Tests Note**

Only subset of browser tests are enabled on Android:
*   components_browsertests
*   content_browsertests

Other browser tests are not supported on Android yet. [crbug/611756]
tracks the effort to enable them on Android.
***

*** note
**Web Tests Note**

Web Tests were enabled on Android K before, but it is disabled on Android platform now,
see [this thread](https://groups.google.com/a/chromium.org/forum/#!topic/blink-dev/338WKwWPbPI/discussion) for more context.
***

*** note
**Tast Tests Note**

Tast tests are written, maintained and gardened by ChromeOS engineers.

ChromeOS tests that Chrome engineers support should be (re)written in the following priority order:
*   unit tests
*   linux_chromeos browser_tests
*   linux_chromeos interactive_ui_tests
*   [Crosier tests](http://go/crosier)

When a Tast test fails:
*   If the change is written by a ChromeOS engineer, the ChromeOS [gardener](http://go/cros-gardening) can revert it.
*   Otherwise the ChromeOS gardener can revert the Chrome-authored change accompanied by a test from the supported frameworks above or manual repro steps that a Chrome engineer can run under [linux_chromeos](../chromeos_build_instructions.md#Chromium-OS-on-Linux-linux_chromeos) (preferable) or using Simple Chrome VM [instructions](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/simple_chrome_workflow.md).
*   If the above is not possible, the ChromeOS gardener or ChromeOS feature owner should inform the author about the failure, and the author uses their best judgment on whether to revert, fix on trunk, or let ChromeOS engineers update the test (e.g. if test needs an update or if the test is just testing internal implementation details of Chrome but doesn''t break user functionality).


***

## General Principles

*   All the tests in Chromium running on CQ and main waterfall should be hermetic and stable.
*   Add unit tests along with the code in same changelist instead of adding tests in future,
    it is most likely no one will add tests later.
*   Write enough unit tests to have good [code coverage](./code_coverage.md),
    since they are fast and stable.
*   Don''t enable tests with external dependencies on CQ and main waterfall,
    e.g. tests against live sites.
    It is fine to check in those tests, but only run them on your own bots.
*   Eventually, all tests should implement the
    [Test Executable API](./test_executable_api.md) command line interface.

## What tests are needed for new features

* **Unit Tests** are needed no matter where the code is for your feature.
  It is the best practice to add the unit tests
  when you add new code or update existing code in the same changelist,
  check out [Code Coverage in Gerrit](./code_coverage_in_gerrit.md)
  for the instruction about how to see the code coverage in Gerrit.
* **Browser Tests** are recommended for integration tests and e2e tests.
  It will be great if you add browser tests to cover the major user
  cases for your feature, even with some mocking.
* **[Web Tests]** are required if you plan to launch new W3C APIs in Chrome.
* **[Instrumentation Tests]** are recommended for features on Android, you only
  need to write instrumentation features
  if your feature is supported on Android for integration tests or e2e tests.
* **EarlGrey Tests** are recommended for iOS only.
* **[Telemetry] benchmarking or stories** are needed if existing telemetry
  benchmarks or stories can''t cover the performance for your feature,
  you need to either add new story, but reuse existing metrics or
  add new benchmarks for your feature. Talk to benchmarking team first
  before start to add Telemetry benchmarks or stories.
* **[Fuzzer Tests]** are recommended if your feature adds user facing APIs
  in Chromium, it is recommended to write fuzzer tests to detect the security issue.

Right now, code coverage is the only way we have to measure test coverage.
The following is the recommended thresholds for different code coverage levels:
* >level 1(improving): >0%
* >level 2(acceptable): 60%
* >level 3(commendable): 75%
* >level 4(exemplary): 90%

Go to [code coverage dashboard](https://analysis.chromium.org/coverage/p/chromium) to check the code coverage for your project.


## How to write new tests
*  [Simple gtests]
*  [Writing JUnit tests]
*  [Writing Browser Tests]
*  [Writing Instrumentation Tests]
*  [Writing EarlGrey Tests]
*  [Writing Telemetry Benchmarks/Stories]
*  [Writing Web Tests](./writing_web_tests.md)
*  [Write Fuzz Target]

>TODO: add the link to the instruction about how to enable new tests in CQ and main waterfall

## How to run tests

### Run tests locally
*  [Run gtest locally](#Run-gtest-locally)
*  [Run browser tests locally]
*  [Run tests on Android](./android_test_instructions.md#Running-Tests)
   It includes the instructions to run gTests, JUnit tests and Instrumentation tests on Android.
*  [Run EarlGrey tests locally](../ios/testing.md#running-tests-from-xcode)
*  [Run Web Tests locally](./web_tests.md#running-web-tests)
*  [Telemetry: Run benchmarks locally]
*  [Run fuzz target locally]

#### Run gtest locally

Before you can run a gtest, you need to build the appropriate launcher target
that contains your test, such as `blink_unittests`:

```bash
autoninja -C out/Default blink_unittests
```

To run specific tests, rather than all tests in a launcher, pass
`--gtest_filter=` with a pattern. The simplest pattern is the full name of a
test (SuiteOrFixtureName.TestName), but you can use wildcards:

```bash
out/Default/blink_unittests --gtest_filter=''Foo*''
```

Use `--help` for more ways to select and run tests.

### Run tests remotely(on Swarming)
>TODO: add the link to the instruction about how to run tests on Swarming.

## How to debug tests
*  [Android Debugging Instructions]
*  [Chrome OS Debugging Tips]
*  [Debugging Web Tests]

## How to deal with flaky tests

Go to [LUCI Analysis] to find reports about flaky tests in your projects.

* [Addressing Flaky GTests](./gtest_flake_tips.md)
* [Addressing Flaky Web Tests](./web_tests_addressing_flake.md)
* [Addressing Flaky WPTs](./web_platform_tests_addressing_flake.md)

If you cannot fix a flaky test in a short timeframe, disable it first to reduce
development pain for other and then fix it later. "[How do I disable a flaky
test]" has instructions on how to disable a flaky test.

## Other

Tests are not configured to upload metrics, such as UMA, UKM or crash reports.

[gtest]: https://github.com/google/googletest
[Simple gtests]: https://github.com/google/googletest/blob/main/docs/primer.md#simple-tests
[Robolectric]: android_robolectric_tests.md
[Instrumentation Tests]: https://chromium.googlesource.com/chromium/src/+/main/docs/testing/android_instrumentation_tests.md
[EarlGrey]: https://github.com/google/EarlGrey
[Telemetry]: https://chromium.googlesource.com/catapult/+/HEAD/telemetry/README.md
[Fuzzer Tests]: https://chromium.googlesource.com/chromium/src/+/main/testing/libfuzzer/README.md
[Tast]: https://chromium.googlesource.com/chromiumos/platform/tast/+/HEAD/README.md
[Web Tests]: ./web_tests.md
[crbug/611756]: https://bugs.chromium.org/p/chromium/issues/detail?id=611756
[LUCI Analysis]: https://luci-analysis.appspot.com/
[Write Fuzz Target]: https://chromium.googlesource.com/chromium/src/+/main/testing/libfuzzer/getting_started.md#write-fuzz-target
[Telemetry: Run benchmarks locally]: https://chromium.googlesource.com/catapult/+/HEAD/telemetry/docs/run_benchmarks_locally.md
[Run fuzz target locally]: https://chromium.googlesource.com/chromium/src/+/main/testing/libfuzzer/getting_started.md#build-and-run-fuzz-target-locally
[Android Debugging Instructions]: https://chromium.googlesource.com/chromium/src/+/HEAD/docs/android_debugging_instructions.md
[Chrome OS Debugging Tips]: ./chromeos_debugging_tips.md
[Debugging Web Tests]: https://chromium.googlesource.com/chromium/src/+/HEAD/docs/testing/web_tests.md#Debugging-Web-Tests
[code coverage dashboard]: https://analysis.chromium.org/p/chromium/coverage
[How do I disable a flaky test]: https://www.chromium.org/developers/tree-sheriffs/sheriff-details-chromium#TOC-How-do-I-disable-a-flaky-test-
', NULL, N'development', N'development/testing/testing_in_chromium', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Code Coverage', N'# Code Coverage in Chromium

### Coverage Dashboard: [link](https://analysis.chromium.org/coverage/p/chromium)

Table of contents:

- [Coverage Infrastructure](#coverage-infra)
  * [Coverage Builders](#coverage-builders)
  * [Coverage Service](#coverage-service)
  * [Coverage Clients](#coverage-clients)
- [Local Coverage Script](#local-coverage-script)
  * [Step 0 Download Tooling](#step-0-download-tooling)
  * [Step 1 Build](#step-1-build)
  * [Step 2 Create Raw Profiles](#step-2-create-raw-profiles)
  * [Step 3 Create Indexed Profile](#step-3-create-indexed-profile)
  * [Step 4 Create Coverage Reports](#step-4-create-coverage-reports)
- [Read The Artifact](#read-the-artifact)
  * [HTML report](#html-report)
  * [lcov report](#lcov-report)
- [Contacts](#contacts)
- [FAQ](#faq)


This document is divided into two parts.
- The first part introduces the code coverage infrastructure that
continuously generates code coverage information for the whole codebase and for
specific CLs in Gerrit. For the latter, refer to
[code\_coverage\_in\_gerrit.md](code_coverage_in_gerrit.md).
- The second part talks about how to generate code coverage locally for Clang-compiled languages like C++. Refer to [android code coverage instructions] for instructions for java code.

## Coverage Infrastructure

![coverage infra diagram]

There are 3 layers in the system:

### Coverage Builders

The first layer is the LUCI builders that
 - build instrumented targets,
 - run the instrumented tests,
 - merge the results into single streams,
 - upload data to cloud storage.

There are two types of builder:

CI Builder

The code coverage CI Builders periodically build all the test targets and fuzzer
targets for a given platform and instrument all available source files. Then
save the coverage data to a dedicated storage bucket.

CQ Builder

The code coverage CQ builders instrument only the files changed for a given CL.
More information about per-cl coverage info in [this
doc](code_coverage_in_gerrit.md).

### Coverage Service

The second layer in the system consists of an AppEngine application that
consumes the coverage data from the builders above, structures it and stores it
in cloud datastore. It then serves the information to the clients below.

### Coverage Clients

In the last layer we currently have two clients that consume the service:

#### Coverage Dashboard

The [coverage dashboard] front end is hosted in the same application as the
service above.
It shows the full-code coverage reports with links to the builds that generated
them, as well as per-directory and per-component aggregation, and can be drilled
down to the single line of code level of detail.

Refer to the following screenshots:

##### Directory View

See coverage breakdown by directories (default landing page).

![coverage dashboard directory view]

##### Component View

Use the view dropdown menu to switch between directory and component.

![coverage dashboard component view]

##### Source View

Click on a particular source file in one of the views above to see line-by-line
coverage breakdown, and it''s useful to identify:
- Uncovered lines and code blocks that lack test coverage.
- Potentially dead code. See [dead code example].
- Hot spots in your code.

![coverage dashboard file view]

##### Project View

Click on "Previous Reports" to check out the coverage history of the project.

![coverage dashboard link to previous reports]

List of historical coverage reports are in reverse chronological order.

![coverage dashboard previous reports]

#### Gerrit Coverage View

The other client supported at the moment is the gerrit plugin for code coverage.

![gerrit coverage view]

See [this doc](code_coverage_in_gerrit.md) for information about the feature
that allows gerrit to display code coverage information generated for a given CL
by CQ bot. Or see this
[15-second video tutorial](https://www.youtube.com/watch?v=cxXlYcSgIPE).

## Local Coverage Script
This [documentation] explains how to use Clang’s source-based coverage
features in general. The [coverage script] automates the process described below and provides a
one-stop service to generate code coverage reports locally in just one command.

This script is currently supported on Android, Linux, Mac, iOS and ChromeOS
platforms.

Here is an example usage:

```
$ gn gen out/coverage \
    --args="use_clang_coverage=true is_component_build=false
    dcheck_always_on=true is_debug=false"
$ python tools/code_coverage/coverage.py \
    crypto_unittests url_unittests \
    -b out/coverage -o out/report \
    -c ''out/coverage/crypto_unittests'' \
    -c ''out/coverage/url_unittests --gtest_filter=URLParser.PathURL'' \
    -f url/ -f crypto/
```
The command above builds `crypto_unittests` and `url_unittests` targets and then
runs them individually with their commands and arguments specified by the `-c` flag.
For `url_unittests`, it only runs the test `URLParser.PathURL`. The coverage report
is filtered to include only files and sub-directories under `url/` and `crypto/`
directories.

Aside from automating the process, this script provides visualization features to
view code coverage breakdown by directories and by components, similar to the
views in the [coverage dashboard](#coverage-dashboard) above.

## Workflow
This section presents the workflow of generating code coverage reports using two
unit test targets in Chromium repo as an example: `crypto_unittests` and
`url_unittests`, and the following diagram shows a step-by-step overview of the
process.

![code coverage generation workflow](images/code_coverage_workflow.png)

### Step 0 Download Tooling
Generating code coverage reports requires llvm-profdata and llvm-cov tools.
You can get them by adding `"checkout_clang_coverage_tools": True,` to
`custom_vars` in the `.gclient` config and run `gclient runhooks`. You can also
download the tools manually ([tools link])

### Step 1 Build
In Chromium, to compile code with coverage enabled, one needs to add
`use_clang_coverage=true`, `is_component_build=false` and `is_debug=false` GN
flags to the args.gn file in the build output directory. Under the hood, they
ensure `-fprofile-instr-generate` and `-fcoverage-mapping` flags are passed to
the compiler.

```
$ gn gen out/coverage \
    --args=''use_clang_coverage=true is_component_build=false is_debug=false''
$ gclient runhooks
$ autoninja -C out/coverage crypto_unittests url_unittests
```

### Step 2 Create Raw Profiles
The next step is to run the instrumented binaries. When the program exits, it
writes a raw profile for each process. Because Chromium runs tests in
multiple processes, the number of processes spawned can be as many as a few
hundred, resulting in the generation of a few hundred gigabytes’ raw
profiles. To limit the number of raw profiles, `%Nm` pattern in
`LLVM_PROFILE_FILE` environment variable is used to run tests in multi-process
mode, where `N` is the number of raw profiles. With `N = 4`, the total size of
the raw profiles are limited to a few gigabytes. (If working on Android, the
.profraw files will be located in ./out/coverage/coverage by default.)

Additionally, we also recommend enabling the continuous mode by adding the `%c`
pattern to `LLVM_PROFILE_FILE`. The continuous mode updates counters in real
time instead of flushing to disk at process exit. This recovers coverage data
from tests that exit abnormally (e.g. death tests). Furthermore, the continuous
mode is required to recover coverage data for tests that run in sandboxed
processes. For more information, see crbug.com/1468343.

```
$ export LLVM_PROFILE_FILE="out/report/crypto_unittests.%4m%c.profraw"
$ ./out/coverage/crypto_unittests
$ ls out/report/
crypto_unittests.3657994905831792357_0.profraw
...
crypto_unittests.3657994905831792357_3.profraw
```

### Step 3 Create Indexed Profile
Raw profiles must be indexed before generating code coverage reports, and this
is done using the `merge` command of `llvm-profdata` tool, which merges multiple
raw profiles (.profraw) and indexes them to create a single profile (.profdata).

At this point, all the raw profiles can be thrown away because their information
is already contained in the indexed profile.

```
$ llvm-profdata merge -o out/report/coverage.profdata \
    out/report/crypto_unittests.3657994905831792357_0.profraw
...
out/report/crypto_unittests.3657994905831792357_3.profraw
out/report/url_unittests.714228855822523802_0.profraw
...
out/report/url_unittests.714228855822523802_3.profraw
$ ls out/report/coverage.profdata
out/report/coverage.profdata
```

### Step 4 Create Coverage Reports
Finally, `llvm-cov` is used to render code coverage reports. There are different
report generation modes, and all of them require the following as input:
- Indexed profile
- All built target binaries
- All exercised source files

For example, the following command can be used to generate per-file line-by-line
code coverage report:

```
$ llvm-cov show -output-dir=out/report -format=html \
    -instr-profile=out/report/coverage.profdata \
    -compilation-dir=out/coverage \
    -object=out/coverage/url_unittests \
    out/coverage/crypto_unittests
```

If creating a report for Android, the -object arg would be the lib.unstripped
file, ie out/coverage/lib.unstripped/libcrypto_unittests__library.so

For more information on how to use llvm-cov, please refer to the [guide].

## Read The Artifact

The code coverage tool generates some artifacts, and it is good to
understand the data format to be used by automation tools.

### HTML Report

If the argument `--format=html` is used in the `llvm-cov export` command, it
generates a report in html format. In this html report, it shows the source
files, lists the functions and coverage metadata on whether the functions are
executed or not.

Reading a html report is straightforward: Just open up this html page with a
Chrome browser.

### lcov Report

If the argument `--format=lcov` is used in the `llvm-cov export` command, it
generates a report in lcov format.

In the lcov file, the meaning of these keywords are listed below.

* `SF`: source file name (typically beginning of one record)
* `FN`: mangled function symbol
* `FNDA`: functions execution
* `FNF`: functions found
* `FNH`: functions hit
* `DA`:  lines executed
* `BRH`: branches hit
* `BRF`: branches found
* `LH`: lines hit
* `LF`: lines found
* `end_of_record` end of one record

The number right after `FN` indicates the starting line number of this function.
The number right after `FNDA` indicates the total number of execution of this
function.

In the following example record, it means that function `_ZN4apps18AppLifetimeMonitorC2EPN7content14BrowserContextE` is defined at line
21 in file `app_lifetime_monitor.cc` and it is executed once.

```
SF:../../chromium/src/apps/app_lifetime_monitor.cc
FN:21,_ZN4apps18AppLifetimeMonitorC2EPN7content14BrowserContextE
FN:32,_ZN4apps18AppLifetimeMonitorD2Ev
FNDA:1,_ZN4apps18AppLifetimeMonitorC2EPN7content14BrowserContextE
FNF:7
FNH:1
DA:34,0
BRF:0
BRH:0
LF:5
LH:1
end_of_record
```

## Contacts

### Reporting problems
For any breakage report and feature requests, please [file a bug].

### Mailing list
For questions and general discussions, please join [code-coverage group].

## FAQ

### Can I use `is_component_build=true` for code coverage build?

Yes, code coverage instrumentation works with both component and non-component
builds. Component build is usually faster to compile, but can be up to several
times slower to run with code coverage instrumentation. For more information,
see [crbug.com/831939].

### I am getting some warnings while using the script, is that fine?

Usually this is not a critical issue, but in general we tend not to have any
warnings. Please check the list of [known issues], and if there is a similar
bug, leave a comment with the command you run, the output you get, and Chromium
revision you use. Otherwise, please [file a bug] providing the same information.

### How do crashes affect code coverage?

If a crash of any type occurs (e.g. Segmentation Fault or ASan error), the
crashing process might not dump coverage information necessary to generate
code coverage report. For single-process applications (e.g. fuzz targets), that
means no coverage might be reported at all. For multi-process applications, the
report might be incomplete. It is important to fix the crash first. If this is
happening only in the coverage instrumented build, please [file a bug].

### How do assertions affect code coverage?

If a crash is caused by CHECK or DCHECK, the coverage dump will still be written
on the disk ([crrev.com/c/1172932]). However, if a crashing process calls the
standard [assert] directly or through a custom wrapper, the dump will not be
written (see [How do crashes affect code coverage?]).

### Is it possible to obtain code coverage from a full Chromium build?

Yes, with some important caveats. It is possible to build `chrome` target with
code coverage instrumentation enabled. However, there are some inconveniences
involved:

* Linking may take a while, especially if you use a non-component build.
* The binary is huge (2-4GB).
* The browser may be noticeably slow and laggy.

For more information, please see [crbug.com/834781].

### Why do we see significantly different coverage reported on different revisions?

There can be two possible scenarios:

* It can be a one time flakiness due to a broken build or failing tests.
* It can be caused by extension of the test suite used for generating code
coverage reports. When we add new tests to the suite, the aggregate coverage
reported usually grows after that.

### How can I improve [coverage dashboard]?

The code for the service and dashboard currently lives along with findit at
[this location](https://chromium.googlesource.com/infra/infra/+/main/appengine/findit/)
because of significant shared logic.

The code used by the bots that generate the coverage data lives (among other
places) in the
[code coverage recipe module](https://chromium.googlesource.com/chromium/tools/build/+/main/scripts/slave/recipe_modules/code_coverage/).

### Why is coverage for X not reported or unreasonably low, even though there is a test for X?

There are several reasons why coverage reports can be incomplete or incorrect:

* A particular test is not used for code coverage report generation. Please
[file a bug].
* A test may have a build failure or a runtime crash. Please check the build
for that particular report (rightmost column on the [coverage dashboard]).
If there is any failure, please upload a CL with the fix. If you can''t fix it,
feel free to [file a bug].
* A particular test may not be available on a particular platform. As of now,
only reports generated on Linux and CrOS are available on the
[coverage dashboard].

### Is coverage reported for the code executed inside the sandbox?

Yes!


[assert]: http://man7.org/linux/man-pages/man3/assert.3.html
[code-coverage group]: https://groups.google.com/a/chromium.org/forum/#!forum/code-coverage
[code-coverage repository]: https://chrome-internal.googlesource.com/chrome/tools/code-coverage
[coverage dashboard]: https://analysis.chromium.org/coverage/p/chromium
[coverage script]: https://cs.chromium.org/chromium/src/tools/code_coverage/coverage.py
[coverage infra diagram]: images/code_coverage_infra_diagram.png
[coverage dashboard file view]: images/code_coverage_dashboard_file_view.png
[coverage dashboard component view]: images/code_coverage_dashboard_component_view.png
[coverage dashboard directory view]: images/code_coverage_dashboard_directory_view.png
[coverage dashboard link to previous reports]: images/code_coverage_dashboard_link_to_previous_reports.png
[coverage dashboard previous reports]: images/code_coverage_dashboard_previous_reports.png
[crbug.com/821617]: https://crbug.com/821617
[crbug.com/831939]: https://crbug.com/831939
[crbug.com/834781]: https://crbug.com/834781
[crrev.com/c/1172932]: https://crrev.com/c/1172932
[clang roll]: https://crbug.com/841908
[dead code example]: https://chromium.googlesource.com/chromium/src/+/ac6e09311fcc7e734be2ef21a9ccbbe04c4c4706
[documentation]: https://clang.llvm.org/docs/SourceBasedCodeCoverage.html
[file a bug]: https://bugs.chromium.org/p/chromium/issues/entry?components=Infra%3ETest%3ECodeCoverage
[gerrit coverage view]: images/code_coverage_annotations.png
[guide]: http://llvm.org/docs/CommandGuide/llvm-cov.html
[How do crashes affect code coverage?]: #how-do-crashes-affect-code-coverage
[known issues]: https://bugs.chromium.org/p/chromium/issues/list?q=component:Infra%3ETest%3ECodeCoverage
[tools link]: https://storage.googleapis.com/chromium-browser-clang-staging/
[android code coverage instructions]: https://chromium.googlesource.com/chromium/src/+/HEAD/build/android/docs/coverage.md
', NULL, N'development', N'development/testing/code_coverage', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Code Coverage in Gerrit', N'# Code Coverage in Gerrit

Tests are critical because they find bugs and regressions, enforce better
designs and make code easier to maintain. **Code coverage helps you ensure your
tests are thorough**.

Chromium CLs can show a line-by-line breakdown of test coverage. **You can use
it to ensure you only submit well-tested code**.

To see code coverage for a Chromium CL, **trigger a CQ dry run**, and once the
builds finish and code coverage data is processed successfully, **look at the
change view to see absolute and incremental code coverage percentages**:

![code_coverage_percentages]

Absolute coverage percentage is the percentage of lines covered by tests
out of **all the lines** in the file, while incremental coverage percentage only
accounts for **newly added or modified lines**. Both these coverage metrics, are further
classified into Unit Tests coverage(coverage from just unit tests) and All Tests coverage(covererd by all tests running in CQ, including unit tests). All Tests coverage is a superset of Unit Tests coverage.

To further dig into specific lines that are not covered by tests, **look at the
right column of the side by side diff view, and specifically notice the
background color of each line number**, where a light orange color indicates
missing coverage and a light blue color indicates existing coverage. Moreover
hovering over the line number shows an informative tooltip with
"Not covered by tests" or "Covered by tests" text respectively. It only shows
All Tests Coverage right now

![code_coverage_annotations]

**Code coverage data is shared between patchsets that are commit-message-edit or
trivial-rebase away**, however, if a newly uploaded patchset has
non-trivial code change, a new CQ dry run must be triggered before coverage data
shows up again.

The code coverage tool supports coverage for C/C++, JAVA and Javascript on all major platforms(Linux, MacOS, Windows, Android, iOS and ChromeOS)

## CLs Blocked Due to Low Coverage
For some teams in Chrome, we have turned on a coverage check, which blocks a CL from submission if the incremental coverage is below a preset threshold(default = 70%). CLs with insufficient test coverage have a `CodeCoverage-1` label added to them, which prevents them from being submitted. Also, a descriptive message is added to the CL, notifying developer of why the CL was blocked, and how to resolve it.
![low_coverage_message]

Once the tests are added, another run of coverage builders (through CQ+1 or CQ+2) changes the label to `CodeCoverage+1`, allowing CLs to proceed with submission.

Tests themselves, as well as test-only files, are generally excluded from coverage checks based on their path or filename. If you are getting coverage warnings for test-related files themselves, check whether the files end in "test" or "tests" (for example, "SomethingTest.java" or "something_unittests.cc") or that their path contains a directory named exactly "test", "tests", or "testing". There is no manual list to which files can be added for long-term exclusion.

Devs can also choose to bypass this block, in case they think they are being unfairly punished. They can do so by adding a *Low-Coverage-Reason: reason* footer to the change description. This should follow certain formatting constraints which are mentioned below

### Mention the Bypass Category

The `reason` string should mention the category the bypass reason belongs to. For e.g. *Low-Coverage-Reason: TRIVIAL_CHANGE This change contains only minor cosmetic changes.* (TRIVIAL_CHANGE is the category)

Available category choices are:
* **TRIVIAL_CHANGE**: CL contains mostly minor changes e.g. renaming, file moves, logging statements, simple interface definitions etc.
* **TESTS_ARE_DISABLED**: Corresponding tests exist, but they are currently disabled.
* **TESTS_IN_SEPARATE_CL**: Developer plan to write tests in a separate CL (Should not be exercised often as per best practices)
* **HARD_TO_TEST**: The code under consideration is hard to test. For e.g. Interfaces with system, real hardware etc.
* **COVERAGE_UNDERREPORTED**: To be used when the developer thinks that tests exist, but corresponding coverage is missing.
* **LARGE_SCALE_REFACTOR**: The current change is part of a large scale refactor. Should explain why the refactor shouldn''t have tests.
* **EXPERIMENTAL_CODE**: The current code is experimental and unlikely to be released to users.
* **OTHER**: None of the above categories are the right fit

In case the developer doesn''t specify the coverage category as prescribed, a warning will be shown in the UI, with details on how to fix
![impropery_formatted_coverage_footer]

### No empty line after the footer
In order for *Low-Coverage-Reason: reason* to work properly, it should occur after the last empty line in CL description, otherwise gerrit recognizes it as part of the commit message, rather than the footer i.e. Following would not work
![empty_line_after_footer]

Removing the empty line should fix it
![no_empty_line_after_footer]

### Be careful with long footer strings
Either keep the footer message in one line i.e. do not add line breaks; or if you do, add whitespace on new footer lines, otherwise [gerrit doesn’t parse them right]. e.g. a long footer message can be written as
![long_footer]
or
![line_break_footer]

## Contacts

### Reporting problems
For any breakage report and feature requests, please [file a bug].

### Mailing list
For questions and general discussions, please join [code-coverage group].

## FAQ
### Why is coverage not shown even though the try job finished successfully?

There are several possible reasons:
* A particular source file/test may not be available on a particular project or
platform.
* There is a bug in the pipeline. Please [file a bug] to report the breakage.

### How does it work?

Please refer to [code_coverage.md] for how code coverage works in Chromium in
general, and specifically, for per-CL coverage in Gerrit, the
[clang_code_coverage_wrapper] is used to compile and instrument ONLY the source
files that are affected by the CL for the sake of performance and a
[chromium-coverage Gerrit plugin] is used to display code coverage information
in Gerrit.


[choose_tryjobs]: images/code_coverage_choose_tryjobs.png
[code_coverage_annotations]: images/code_coverage_annotations.png
[code_coverage_percentages]: images/code_coverage_percentages.png
[low_coverage_message]: images/low_coverage_message.png
[empty_line_after_footer]: images/empty_line_after_footer.png
[no_empty_line_after_footer]: images/no_empty_line_after_footer.png
[long_footer]: images/long_footer.png
[line_break_footer]: images/line_break_footer.png
[impropery_formatted_coverage_footer]: images/improperly_formatted_coverage_footer.png
[file a bug]: https://bugs.chromium.org/p/chromium/issues/entry?components=Infra%3ETest%3ECodeCoverage
[code-coverage group]: https://groups.google.com/a/chromium.org/forum/#!forum/code-coverage
[code_coverage.md]: code_coverage.md
[clang_code_coverage_wrapper]: https://chromium.googlesource.com/chromium/src/+/main/docs/clang_code_coverage_wrapper.md
[chromium-coverage Gerrit plugin]: https://chromium.googlesource.com/infra/gerrit-plugins/code-coverage/
[gerrit doesn’t parse them right]: https://bugs.chromium.org/p/chromium/issues/detail?id=1459714#c9
', NULL, N'development', N'development/testing/code_coverage_in_gerrit', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Life of Increasing Coverage', N'# Life of Increasing Code Coverage

The goal of this doc is to provide guidance on how to write better tests using
code coverage information rather than increase code coverage itself.

1. Pay attention to **untested** code in both the
[coverage dashboard](https://analysis.chromium.org/coverage/p/chromium) and
[code coverage in Gerrit](code_coverage_in_gerrit.md) during code review.

2. Is this dead code? If yes, draft a CL
([example](https://chromium-review.googlesource.com/c/chromium/src/+/1550769))
to remove it, otherwise, please go to step 3.

3. Think about why the code is not covered by any test. Is it because it''s
too complicated to be testable? If yes, draft a CL to refactor the code and add
tests ([example](https://chromium-review.googlesource.com/c/chromium/src/+/1558233)),
otherwise, please go to step 4.

4. If the code is testable, but a test was forgotten, draft a CL to add
tests for it ([example](https://chromium-review.googlesource.com/c/chromium/src/+/1447030)).

Anytime you upload a CL to refactor or add tests, you can use
[code coverage in Gerrit](code_coverage_in_gerrit.md) to help you verify the
previously untested code is now tested by your CL.

Please refer to [code_coverage.md](code_coverage.md) for how code coverage works
in Chromium in general.

### Contacts

For any breakage report and feature requests, please
[file a bug](https://bugs.chromium.org/p/chromium/issues/entry?components=Infra%3ETest%3ECodeCoverage).

For questions and general discussions, please join
[code-coverage group](https://groups.google.com/a/chromium.org/forum/#!forum/code-coverage).
', NULL, N'development', N'development/testing/life_of_increasing_code_coverage', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Test Descriptions', N'See [Testing and infrastructure](https://sites.google.com/a/chromium.org/dev/developers/testing) for more information.

| Type of test           | Description |
|:-----------------------|:------------|
|accessibility\_unittests| |
|angle\_unittests        | |
|app\_list\_unittests    | |
|ash\_unittests          | |
|aura\_unittests         | |
|base\_i18n\_perftests   | |
|base\_perftests         |Performance tests for base module.|
|base\_unittests         |Tests the base module.|
|blink\_heap\_unittests  | |
|blink\_platform\_unittests| |
|breakpad\_unittests     | |
|[browser\_tests](https://sites.google.com/a/chromium.org/dev/developers/testing/browser-tests)|Tests the browser UI. Can not inject user input or depend on focus/activation behavior because it can be run in parallel processes and/or with a locked screen, headless etc. For tests sensitive to that, use interactive\_ui\_tests. For example, when tests need to navigate to chrome://hang (see chrome/browser/ui/webui/ntp/new\_tab\_ui\_uitest.cc)|
|chromedriver\_unittests | |
|content\_browsertests   |Similar to browser\_tests, but with a minimal shell contained entirely within content/. This test, as well as the entire content module, has no dependencies on chrome/.|
|content\_gl\_tests      | |
|content\_perftests      | |
|content\_unittests      | |
|courgette\_unittests    | |
|crypto\_unittests       | |
|curvecp\_unittests      | |
|device\_unittests       |Tests for the device (Bluetooth, HID, USB, etc.) APIs.|
|ffmpeg\_tests           | |
|ffmpeg\_unittests       | |
|gfx\_unittests          | |
|gpu\_tests              | |
|interactive\_ui\_tests  |Like browser\_tests, but these tests do things like changing window focus, so that the machine running the test can''t be used while the test is running. May include browsertests (derived from InProcessBrowserTest) to run in-process in case when the test is sensitive to focus transitions or injects user input/mouse events.|
|ipc\_tests              |Tests the IPC subsystem for communication between browser, renderer, and plugin processes.|
|jingle\_unittests       | |
|media\_unittests        | |
|memory\_test            | |
|net\_perftests          |Performance tests for the disk cache and cookie storage.|
|net\_unittests          |Unit tests network stack.|
|[page\_cycler\_tests](https://sites.google.com/a/chromium.org/dev/developers/testing/page-cyclers)| |
|performance\_ui\_tests  | |
|plugin\_tests           |Tests the plugin subsystem.|
|ppapi\_unittests        |Tests to verify Chromium recovery after hanging or crashing of renderers.|
|printing\_unittests     | |
|reliability\_tests      | |
|safe\_browsing\_tests   | |
|sql\_unittests          | |
|startup\_tests          |Test startup performance of Chromium.|
|sync\_integration\_tests| |
|sync\_unit\_tests       | |
|tab\_switching\_test    |Test tab switching functionality.|
|telemetry\_unittests    |Tests for the core functionality of the Telemetry performance testing framework. Not performance-sensitive.|
|telemetry\_perf\_unittests|Smoke tests to catch errors running performance tests before they run on the chromium.perf waterfall. Not performance-sensitive.|
|test\_shell\_tests      |A collection of tests within the Test Shell.|
|[test\_installer](https://sites.google.com/a/chromium.org/dev/developers/testing/windows-installer-tests)|Tests Chrome''s installer for Windows|
|ui\_base\_unittests     |Unit tests for //ui/base.|
|unit\_tests             |The kitchen sink for unit tests. These tests cover several modules within Chromium.|
|url\_unittests          | |
|views\_unittests        | |
|wav\_ola\_test          | |
|webkit\_unit\_tests     | |
|webui tests             | Special type of browser\_tests used for [WebUI features](https://chromium.googlesource.com/chromium/src/+/main/docs/webui/webui_explainer.md), see [here](https://docs.google.com/document/d/1Z18WTNv28z5FW3smNEm_GtsfVD2IL-CmmAikwjw3ryo/edit#) for more information on known issues with WebUI test infrastructure. |
', NULL, N'development', N'development/testing/test_descriptions', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Test Executable API', N'# The Chromium Test Executable API

[bit.ly/chromium-test-runner-api][1] (*)


[TOC]

## Introduction

This document defines the API that test executables must implement in order to
be run on the Chromium continuous integration infrastructure (the
[LUCI][2]
system using the `chromium` and `chromium_trybot` recipes).

*** note
**NOTE:** This document specifies the existing `isolated_scripts` API in the
Chromium recipe. Currently we also support other APIs (e.g., for
GTests), but we should migrate them to use the `isolated_scripts` API.
That work is not currently scheduled.
***

This spec applies only to functional tests and does not attempt to
specify how performance tests should work, though in principle they
could probably work the same way and possibly just produce different
output.

This document is specifically targeted at Chromium and assumes you are
using GN and Ninja for your build system. It should be possible to adapt
these APIs to other projects and build recipes, but this is not an
immediate goal. Similarly, if a project adapts this API and the related
specifications it should be able to reuse the functionality and tooling
we''ve built out for Chromium''s CI system more easily in other LUCI
deployments.

***
**NOTE:** It bears repeating that this describes the current state of
affairs, and not the desired end state. A companion doc,
[Cleaning up the Chromium Testing Environment][3],
discusses a possible path forward and end state.
***

## Building and Invoking a Test Executable

There are lots of different kinds of tests, but we want to be able to
build and invoke them uniformly, regardless of how they are implemented.

We will call the thing being executed to run the tests a _test
executable_ (or executable for short). This is not an ideal name, as
this doesn''t necessarily refer to a GN executable target type; it may be
a wrapper script that invokes other binaries or scripts to run the
tests.

We expect the test executable to run one or more tests. A _test_ must be
an atomically addressable thing with a name that is unique to that
invocation of the executable, i.e., we expect that we can pass a list of
test names to the test executable and only run just those tests. Test
names must not contain a "::" (which is used as a separator between test
names) and must not contain a "*" (which could be confused with a glob
character) or start with a "-" (which would be confused with an
indicator that you should skip the test). Test names should generally
only contain ASCII code points, as the infrastructure does not currently
guarantee that non-ASCII code points will work correctly everywhere. We
do not specify test naming conventions beyond these requirements, and it
is fully permissible for a test to contain multiple assertions which may
pass or fail; this design does not specify a way to interpret or handle
those "sub-atomic" assertions; their existence is opaque to this design.
In particular, this spec does not provide a particular way to identify
and handle parameterized tests, or to do anything with test suites
beyond a supporting a limited form of globbing for specifying sets of
test names.

To configure a new test, you need to modify one to three files:

*   The test must be listed in one or more test suites in
    [//testing/buildbot/test_suites.pyl][4].  Most commonly the test will be
    defined as a single string (e.g., "base_unittests"), which keys into an
    entry in [//testing/buildbot/gn_isolate_map.pyl][5].  In some cases, tests
    will reference a target and add additional command line arguments. These
    entries (along with [//testing/buildbot/test_suite_exceptions.pyl][6] and
    [//testing/buildbot/waterfalls.pyl][7]) determine where the tests will be
    run. For more information on how these files work, see
    [//testing/buildbot/README.md][8]
*   Tests entries must ultimately reference an entry in
    //testing/buildbot/gn_isolate_map.pyl. This file contains the mapping of
    ninja compile targets to GN targets (specifying the GN label for the
    latter); we need this mapping in order to be able to run `gn analyze`
    against a patch to see which targets are affected by a patch. This file
    also tells MB what kind of test an entry is (so we can form the correct
    command line) and may specify additional command line flags. If you are
    creating a test that is only a variant of an existing test, this may be the
    only file you need to modify. (Technically, you could define a new test
    solely in test_suites.pyl and reference existing gn_isolate_map.pyl
    entries, but this is considered bad practice).
*   Add the GN target itself to the appropriate build files. Make sure this GN
    target contains all of the data and data_deps entries needed to ensure the
    test isolate has all the files the test needs to run.  If your test doesn''t
    depend on new build targets or add additional data file dependencies, you
    likely don''t need this. However, this is increasingly uncommon.

### Command Line Arguments

The executable must support the following command line arguments (aka flags):

```
--isolated-outdir=[PATH]
```

This argument is required, and should be set to the directory created
by the swarming task for the task to write outputs into.

```
--out-dir=[PATH]
```

This argument mirrors `--isolated-outdir`, but may appear in addition to
it depending on the bot configuration (e.g. IOS bots that specify the
`out_dir_arg` mixin in //testing/buildbot/waterfalls.pyl). It only needs
to be handled in these cases.

```
--isolated-script-test-output=[FILENAME]
```

This argument is optional. If this argument is provided, the executable
must write the results of the test run in the [JSON Test
Results Format](json_test_results_format.md) into
that file. If this argument is not given to the executable, the
executable must not write the output anywhere. The executable should
only write a valid version of the file, and generally should only do
this at the end of the test run. This means that if the run is
interrupted, you may not get the results of what did run, but that is
acceptable.

```
--isolated-script-test-filter=[STRING]
```

This argument is optional. If this argument is provided, it must be a
double-colon-separated list of strings, where each string either
uniquely identifies a full test name or is a prefix plus a "*" on the
end (to form a glob). The executable must run only the test matching
those names or globs. "*" is _only_ supported at the end, i.e., ''Foo.*''
is legal, but ''*.bar'' is not. If the string has a "-" at the front, the
test (or glob of tests) must be skipped, not run. This matches how test
names are specified in the simple form of the [Chromium Test List
Format][9]. We use the double
colon as a separator because most other common punctuation characters
can occur in test names (some test suites use URLs as test names, for
example). This argument may be provided multiple times; how to treat
multiple occurrences (and how this arg interacts with
--isolated-script-test-filter-file) is described below.

```
--isolated-script-test-filter-file=[FILENAME]
```

If provided, the executable must read the given filename to determine
which tests to run and what to expect their results to be. The file must
be in the [Chromium Test List Format][9] (either the simple or
tagged formats are fine). This argument may be provided multiple times;
how to treat multiple occurrences (and how this arg interacts with
`--isolated-script-test-filter`) is described below.

```
--isolated-script-test-launcher-retry-limit=N
```

By default, tests are run only once if they succeed. If they fail, we
will retry the test up to N times (so, for N+1 total invocations of the
test) looking for a success (and stop retrying once the test has
succeed). By default, the value of N is 3. To turn off retries, pass
`--isolated-script-test-launcher-retry-limit=0`. If this flag is provided,
it is an error to also pass `--isolated-script-test-repeat` (since -repeat
specifies an explicit number of times to run the test, it makes no sense
to also pass --retry-limit).

```
--isolated-script-test-repeat=N
```

If provided, the executable must run a given test N times (total),
regardless of whether the test passes or fails. By default, tests are
only run once (N=7) if the test matches an expected result or passes,
otherwise it may be retried until it succeeds, as governed by
`--isolated-script-test-launcher-retry-limit`, above. If this flag is
provided, it is an error to also pass
`--isolated-script-test-launcher-retry-limit` (since -repeat specifies an
explicit number of times to run the test, it makes no sense to also pass
-retry-limit).

```
--xcode-build-version [VERSION]
```

This flag is passed to scripts on IOS bots only, due to the `xcode_14_main`
mixin in //testing/builtbot/waterfalls.pyl.

```
--xctest
```

This flag is passed to scripts on IOS bots only, due to the `xctest`
mixin in //testing/builtbot/waterfalls.pyl.

If "`--`" is passed as an argument:

*   If the executable is a wrapper that invokes another underlying
    executable, then the wrapper must handle arguments passed before the
    "--" on the command line (and must error out if it doesn''t know how
    to do that), and must pass through any arguments following the "--"
    unmodified to the underlying executable (and otherwise ignore them
    rather than erroring out if it doesn''t know how to interpret them).
*   If the executable is not a wrapper, but rather invokes the tests
    directly, it should handle all of the arguments and otherwise ignore
    the "--". The executable should error out if it gets arguments it
    can''t handle, but it is not required to do so.

If "--" is not passed, the executable should error out if it gets
arguments it doesn''t know how to handle, but it is not required to do
so.

If the test executable produces artifacts, they should be written to the
location specified by the dirname of the `--isolated-script-test-output`
argument). If the `--isolated-script-test-output-argument` is not
specified, the executable should store the tests somewhere under the
root_build_dir, but there is no standard for how to do this currently
(most tests do not produce artifacts).

The flag names are purposely chosen to be long in order to not conflict
with other flags the executable might support.

### Environment variables

The executable must check for and honor the following environment variables:

```
GTEST_SHARD_INDEX=[N]
```

This environment variable is optional, but if it is provided, it
partially determines (along with `GTEST_TOTAL_SHARDS`) which fixed
subset of tests (or "shard") to run. `GTEST_TOTAL_SHARDS` must also be
set, and `GTEST_SHARD_INDEX` must be set to an integer between 0 and
`GTEST_TOTAL_SHARDS`. Determining which tests to run is described
below.

```
GTEST_TOTAL_SHARDS=[N]
```

This environment variable is optional, but if it is provided, it
partially determines (along with `GTEST_TOTAL_SHARDS`) which fixed subset
of tests (or "shard") to run. It must be set to a non-zero integer.
Determining which tests to run is described below.

### Exit codes (aka return codes or return values)

The executable must return 0 for a completely successful run, and a
non-zero result if something failed. The following codes are recommended
(2 and 130 coming from UNIX conventions):

| Value    | Meaning |
|--------- | ------- |
| 0 (zero) | The executable ran to completion and all tests either ran as expected or passed unexpectedly.          |
| 1        | The executable ran to completion but some tests produced unexpectedly failing results.                 |
| 2        | The executable failed to start, most likely due to unrecognized or unsupported command line arguments. |
| 130      | The executable run was aborted the user (or caller) in a semi-orderly manner (aka SIGKILL or Ctrl-C).  |

## Filtering which tests to run

By default, the executable must run every test it knows about. However,
as noted above, the `--isolated-script-test-filter` and
`--isolated-script-test-filter-file` flags can be used to customize which
tests to run. Either or both flags may be used, and either may be
specified multiple times.

The interaction is as follows:

*   A test should be run only if it would be run when **every** flag is
    evaluated individually.
*   A test should be skipped if it would be skipped if **any** flag was
    evaluated individually.

If multiple filters in a flag match a given test name, the longest match
takes priority (longest match wins). I.e.,. if you had
`--isolated-script-test-filter=''a*::-ab*''`, then `ace.html` would run but
`abd.html` would not. The order of the filters should not matter. It is
an error to have multiple expressions of the same length that conflict
(e.g., `a*::-a*`).

Examples are given below.

It may not be obvious why we need to support these flags being used multiple
times, or together. There are two main sets of reasons:
*   First, you may want to use multiple -filter-file arguments to specify
    multiple sets of test expectations (e.g., the base test expectations and
    then MSAN-specific expectations), or to specify expectations in one file
    and list which tests to run in a separate file.
*   Second, the way the Chromium recipes work, in order to retry a test step to
    confirm test failures, the recipe doesn''t want to have to parse the
    existing command line, it just wants to append
    --isolated-script-test-filter and list the
    tests that fail, and this can cause the --isolated-script-test-filter
    argument to be listed multiple times (or in conjunction with
    --isolated-script-test-filter-file).

You cannot practically use these mechanisms to run equally sized subsets of the
tests, so if you want to do the latter, use `GTEST_SHARD_INDEX` and
`GTEST_TOTAL_SHARDS` instead, as described in the next section.

## Running equally-sized subsets of tests (shards)

If the `GTEST_SHARD_INDEX` and `GTEST_TOTAL_SHARDS` environment variables are
set, `GTEST_TOTAL_SHARDS` must be set to a non-zero integer N, and
`GTEST_SHARD_INDEX` must be set to an integer M between 0 and N-1. Given those
two values, the executable must run only every N<sup>th</sup> test starting at
test number M (i.e., every i<sup>th</sup> test where (i mod N) == M).  dd

This mechanism produces roughly equally-sized sets of tests that will hopefully
take roughly equal times to execute, but cannot guarantee the latter property
to any degree of precision. If you need them to be as close to the same
duration as possible, you will need a more complicated process. For example,
you could run all of the tests once to determine their individual running
times, and then build up lists of tests based on that, or do something even
more complicated based on multiple test runs to smooth over variance in test
execution times. Chromium does not currently attempt to do this for functional
tests, but we do something similar for performance tests in order to better
achieve equal running times and device affinity for consistent results.

You cannot practically use the sharding mechanism to run a stable named set of
tests, so if you want to do the latter, use the `--isolated-script-test-filter`
flags instead, as described in the previous section.

Which tests are in which shard must be determined **after** tests have been
filtered out using the `--isolated-script-test-filter(-file)` flags.

The order that tests are run in is not otherwise specified, but tests are
commonly run either in lexicographic order or in a semi-fixed random order; the
latter is useful to help identify inter-test dependencies, i.e., tests that
rely on the results of previous tests having run in order to pass (such tests
are generally considered to be undesirable).

## Examples

Assume that out/Default is a debug build (i.e., that the "Debug" tag will
apply), and that you have tests named Foo.Bar.bar{1,2,3}, Foo.Bar.baz,
and Foo.Quux.quux, and the following two filter files:

```sh
$ cat filter1
Foo.Bar.*
-Foo.Bar.bar3
$ cat filter2
# tags: [ Debug Release ]
[ Debug ] Foo.Bar.bar2 [ Skip ]
$
```

#### Filtering tests on the command line

```sh
$ out/Default/bin/run_foo_tests \
    --isolated_script-test-filter=''Foo.Bar.*::-Foo.Bar.bar3''
[1/2] Foo.Bar.bar1 passed in 0.1s
[2/2] Foo.Bar.bar2 passed in 0.13s

2 tests passed in 0.23s, 0 skipped, 0 failures.
$
```

#### Using a filter file

```sh
$ out/Default/bin/run_foo_tests --isolated-script-test-filter-file=filter1
[1/2] Foo.Bar.bar1 passed in 0.1s
[2/2] Foo.Bar.bar2 passed in 0.13s

2 tests passed in 0.23s, 0 skipped, 0 failures.
```

#### Combining multiple filters

```sh
$ out/Default/bin/run_foo_tests --isolated-script-test-filter=''Foo.Bar.*'' \
    --isolated-script-test-filter=''Foo.Bar.bar2''
[1/1] Foo.Bar.bar2 passed in 0.13s

All 2 tests completed successfully in 0.13s
$ out/Default/bin/run_foo_tests --isolated-script-test-filter=''Foo.Bar.* \
    --isolated-script-test-filter=''Foo.Baz.baz''
No tests to run.
$ out/Default/bin/run_foo_tests --isolated-script-test-filter-file=filter2 \
    --isolated-script-test-filter=-FooBaz.baz
[1/4] Foo.Bar.bar1 passed in 0.1s
[2/4] Foo.Bar.bar3 passed in 0.13s
[3/4] Foo.Baz.baz passed in 0.05s

3 tests passed in 0.28s, 2 skipped, 0 failures.
$
```

#### Running one shard of tests

```sh
$ GTEST_TOTAL_SHARDS=3 GTEST_SHARD_INDEX=1 out/Default/bin/run_foo_tests
Foo.Bar.bar2 passed in 0.13s
Foo.Quux.quux1 passed in 0.02s

2 tests passed in 0.15s, 0 skipped, 0 failures.
$
```

## Related Work

This document only partially makes sense in isolation.

The [JSON Test Results Format](json_test_results_format.md) document
specifies how the results of the test run should be reported.

The [Chromium Test List Format][14] specifies in more detail how we can specify
which tests to run and which to skip, and whether the tests are expected to
pass or fail.

Implementing everything in this document plus the preceding three documents
should fully specify how tests are run in Chromium. And, if we do this,
implementing tools to manage tests should be significantly easier.

[On Naming Chromium Builders and Build Steps][15] is a related proposal that
has been partially implemented; it is complementary to this work, but not
required.

[Cleaning up the Chromium Testing Conventions][3] describes a series of
changes we might want to make to this API and the related infrastructure to
simplify things.

Additional documents that may be of interest:
*   [Testing Configuration Files][8]
*   [The MB (Meta-Build wrapper) User Guide][10]
*   [The MB (Meta-Build wrapper) Design Spec][11]
*   [Test Activation / Deactivation (TADA)][12] (internal Google document only,
    sorry)
*   [Standardize Artifacts for Chromium Testing][13] is somewhat dated but goes
    into slightly greater detail on how to store artifacts produced by tests
    than the JSON Test Results Format does.

## Document history

\[ Significant changes only. \]

| Date       | Comment  |
| ---------- | -------- |
| 2017-12-13 | Initial version. This tried to be a full-featured spec that defined common flags that devs might want with friendly names, as well the flags needed to run tests on the bots. |
| 2019-05-24 | Second version. The spec was significantly revised to just specify the minimal subset needed to run tests consistently on bots given the current infrastructure. |
| 2019-05-29 | All TODOs and discussion of future work was stripped out; now the spec only specifies how the `isolated_scripts` currently behave. Future work was moved to a new doc, [Cleaning up the Chromium Testing Environment][3]. |
| 2019-09-16 | Add comment about ordering of filters and longest match winning for `--isolated-script-test-filter`. |
| 2020-07-01 | Moved into the src repo and converted to Markdown. No content changes otherwise. |

## Notes

(*) The initial version of this document talked about test runners instead of
test executables, so the bit.ly shortcut URL refers to the test-runner-api instead of
the test-executable-api. The author attempted to create a test-executable-api link,
but pointed it at the wrong document by accident. bit.ly URLs can''t easily be
updated :(.

[1]: https://bit.ly/chromium-test-runner-api
[2]: https://chromium.googlesource.com/infra/infra/+/main/doc/users/services/about_luci.md
[3]: https://docs.google.com/document/d/1MwnIx8kavuLSpZo3JmL9T7nkjTz1rpaJA4Vdj_9cRYw/edit?usp=sharing
[4]: ../../testing/buildbot/test_suites.pyl
[5]: ../../testing/buildbot/gn_isolate_map.pyl
[6]: ../../testing/buildbot/test_suite_exceptions.pyl
[7]: ../../testing/buildbot/waterfalls.pyl
[8]: ../../testing/buildbot/README.md
[9]: https://bit.ly/chromium-test-list-format
[10]: ../../tools/mb/docs/user_guide.md
[11]: ../../tools/mb/docs/design_spec.md
[12]: https://goto.google.com/chops-tada
[13]: https://bit.ly/chromium-test-artifacts
[14]: https://bit.ly/chromium-test-list-format
[15]: https://bit.ly/chromium-build-naming
', NULL, N'development', N'development/testing/test_executable_api', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Test Wrapper API', N'# Test Wrapper API

In order to simplify the calling conventions for tests that we run on our
continuous integration system, we require them to follow a simple API
convention. For a given GN label //X:Y and build directory //Z in a checkout
(e.g., //url:url_unittests and //out/Release), we expect there to be:

    * A file `$Z/$Y.runtime_deps` containing a list of files needed to run
      the test (in the format produced by `gn desc //Z //X:Y runtime_deps`,
      which is a newline-separated list of paths relative to Z)
    * An executable file `$Z/bin/run_$Y` which does everything needed to set
      up and run the test with all of the appropriate flags. This will usually
      be a vpython script.
    * (on Windows) A file `$Z/bin/run_$Y.bat` file that will turn around
      and invoke the corresponding run_$ vpython script.

If you create a directory snapshot with the files listed in the .runtime_deps
file, cd to $Z, and run bin/run_$Y, then the test should run to completion
successfully.

The script file MUST honor the `GTEST_SHARD_INDEX` and `GTEST_TOTAL_SHARDS`
environment variables as documented in
[the Test Executable API](test_executable_api.md) and SHOULD conform to
the Test Executable API in other respects (i.e., honor the
`--isolated-script-test-filter` arg and other command line flags specified
in that API).

TODO(crbug.com/40564748): Convert everything to the Test Executable API, and
change the above SHOULD to a MUST.
', NULL, N'development', N'development/testing/test_wrapper_api', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Test Browser Dialog', N'# Testing Chrome browser UI with TestBrowserUi

\#include "[chrome/browser/ui/test/test_browser_ui.h]"

`TestBrowserUi` (and convenience class `TestBrowserDialog`) provide ways to
register an `InProcessBrowserTest` testing harness with a framework that invokes
Chrome browser UI in a consistent way. They optionally provide a way to invoke
UI "interactively". This allows screenshots to be generated easily, with the
same test data, to assist with UI review. `TestBrowserUi` also provides a UI
registry so pieces of UI can be systematically checked for subtle changes and
regressions.

[TOC]

## How to register UI

If registering existing UI, there''s a chance it already has a test harness
inheriting, using, or with `typedef InProcessBrowserTest` (or a descendant of
it). If so, using `TestBrowserDialog` (for a dialog) is straightforward, and
`TestBrowserUi` (for other types of UI) relatively so. Assume the existing
`InProcessBrowserTest` is in `foo_browsertest.cc`:

    class FooUiTest : public InProcessBrowserTest { ...

Change this to inherit from `DialogBrowserTest` (for dialogs) or `UiBrowserTest`
(for non-dialogs), and override `ShowUi(std::string)`. For non-dialogs, also
override `VerifyUi()` and `WaitForUserDismissal()`. See
[Advanced Usage](#Advanced-Usage) for details.

```cpp
class FooUiTest : public UiBrowserTest {
 public:
  ..
  // UiBrowserTest:
  void ShowUi(const std::string& name) override {
    /* Show Ui attached to browser() and leave it open. */
  }
  // These next two are not necessary if subclassing DialogBrowserTest.
  bool VerifyUi() override {
    /* Return true if the UI was successfully shown. */
  }
  void WaitForUserDismissal() override {
    /* Block until the UI has been dismissed. */
  }
  ..
};
```

Finally, add test invocations using the usual GTest macros, in
`foo_browsertest.cc`:

```cpp
IN_PROC_BROWSER_TEST_F(FooUiTest, InvokeUi_default) {
  ShowAndVerifyUi();
}
```

Notes:

*   The body of the test is always just "`ShowAndVerifyUi();`".
*   "`default`" is the `std::string` passed to `ShowUi()` and can be
    customized. See
    [Testing additional UI "styles"](#Testing-additional-ui-styles).
*   The text before `default` (in this case) must always be "`InvokeUi_`".

### Concrete examples

*   [chrome/browser/ui/ask_google_for_suggestions_dialog_browsertest.cc]
*   [chrome/browser/infobars/infobars_browsertest.cc]

##  Running the tests

List the available pieces of UI with

    $ ./browser_tests --gtest_filter=BrowserUiTest.Invoke
    $ ./interactive_ui_tests --gtest_filter=BrowserInteractiveUiTest.Invoke

E.g. `FooUiTest.InvokeUi_default` should be listed. To show the UI
interactively, run

    # If FooUiTest is a browser test.
    $ ./browser_tests --gtest_filter=BrowserUiTest.Invoke \
      --test-launcher-interactive --ui=FooUiTest.InvokeUi_default

    # If FooUiTest is an interactive UI test.
    $ ./interactive_ui_tests --gtest_filter=BrowserInteractiveUiTest.Invoke \
      --test-launcher-interactive --ui=FooUiTest.InvokeUi_default

### Implementation

`BrowserUiTest.Invoke` searches for gtests that have "`InvokeUi_`"  in their
names, so they can be collected in a list. Providing a `--ui` argument will
invoke that test case in a subprocess. Including `--test-launcher-interactive`
will set up an environment for that subprocess that allows interactivity, e.g.,
to take screenshots. The test ends once the UI is dismissed.

The `FooUiTest.InvokeUi_default` test case **will still be run in the usual
browser_tests test suite**. Ensure it passes, and isn’t flaky. This will
give your UI some regression test coverage. `ShowAndVerifyUi()` checks to ensure
UI is actually created when it invokes `ShowUi("default")`.

`BrowserInteractiveUiTest` is the equivalent of `BrowserUiTest` for
interactive_ui_tests.

### BrowserUiTest.Invoke

This is also run in browser_tests but, when run that way, the test case just
lists the registered test harnesses (it does *not* iterate over them). A
subprocess is never created unless --ui is passed on the command line.

## Advanced Usage

If your test harness inherits from a descendant of `InProcessBrowserTest` (one
example: [ExtensionBrowserTest]) then the `SupportsTestUi<>` and
`SupportsTestDialog` templates are provided. E.g.

```cpp
class ExtensionInstallDialogViewTestBase : public ExtensionBrowserTest { ...
```

becomes

```cpp
class ExtensionInstallDialogViewTestBase :
    public SupportsTestDialog<ExtensionBrowserTest> { ...
```

If you need to do any setup before `ShowUi()` is called, or any teardown in the
non-interactive case, you can override the `PreShow()` and `DismissUi()
methods.

### Testing additional UI "styles"

Add additional test cases, with a different string after "`InvokeUi_`".
Example:

```cpp
IN_PROC_BROWSER_TEST_F(CardUnmaskViewBrowserTest, InvokeUi_expired) {
  ShowAndVerifyUi();
}

IN_PROC_BROWSER_TEST_F(CardUnmaskViewBrowserTest, InvokeUi_valid) {
  ShowAndVerifyUi();
}
```

The strings "`expired`" or “`valid`” will be given as arguments to
`ShowUi(std::string)`.

## Rationale

Bug reference: [Issue 654151](http://crbug.com/654157).

Chrome has a lot of browser UI; often for obscure use-cases and often hard to
invoke. It has traditionally been difficult to be systematic while checking UI
for possible regressions. For example, to investigate changes to shared layout
parameters which are testable only with visual inspection.

For Chrome UI review, screenshots need to be taken. Iterating over all the
"styles" that UI may appear with is fiddly. E.g. a login or particular web
server setup may be required. It’s important to provide a consistent “look” for
UI review (e.g. same test data, same browser size, anchoring position, etc.).

Some UI lacks tests. Some UI has zero coverage on the bots. UI elements can have
tricky lifetimes and common mistakes are repeated. TestBrowserUi runs simple
"Show UI" regression tests and can be extended to do more.

Even discovering the full set of UI present for each platform in Chrome is
[difficult](http://crbug.com/686239).

### Why browser_tests?

*   `browser_tests` already provides a `browser()->window()` of a consistent
    size that can be used as a dialog anchor and to take screenshots for UI
    review.
    *   UI review have requested that screenshots be provided with the entire
        browser window so that the relative size of the UI element/change under
        review can be assessed.

*   Some UI already has a test harness with appropriate setup (e.g. test data)
    running in browser_tests.
    *   Supporting `BrowserUiTest` should require minimal setup and minimal
        ongoing maintenance.

*   An alternative is to maintain a working end-to-end build target executable
    to do this, but this has additional costs (and is hard).
    *    E.g. setup/teardown of low-level functions
         (`InitializeGLOneOffPlatform()`, etc.).

*   Why not chrome.exe?
    *   E.g. a scrappy chrome:// page with links to invoke UI would be great!
    *   But...
        *   UI may have test data (e.g. credit card info) which shouldn’t be in
        the release build.
        *   UI may use EmbeddedTestServer.
        *   Higher maintenance cost - can’t leverage existing test harnesses.

## Future Work

*   Opt in more UI!
    *    Eventually, all of it.
    *    A `DialogBrowserTest` for every descendant of `views::DialogDelegate`.

*   Automatically generate screenshots (for each platform, in various languages)
    *    Build upon [CL 2008283002](https://codereview.chromium.org/2008283002/)

*   (maybe) Try removing the subprocess
    *    Probably requires altering the browser_test suite code directly rather
         than just adding a test case as in the current approach

*   An automated test suite for UI
    *    Test various ways to dismiss or hide UI, especially dialogs
         *    e.g. native close (via taskbar?)
         *    close parent window (possibly via task bar)
         *    close parent tab
         *    switch tabs
         *    close via `DialogClientView::AcceptWindow` (and `CancelWindow`)
         *    close via `Widget::Close`
         *    close via `Widget::CloseNow`
    *    Drag tab off browser into a new window
    *    Fullscreen that may create a new window/parent

*   Find obscure workflows for invoking UI that has no test coverage and causes
    crashes (e.g. [http://crrev.com/426302](http://crrev.com/426302))
    *   Supporting window-modal dialogs with a null parent window.

*   Find memory leaks, e.g. [http://crrev.com/432320](http://crrev.com/432320)
    *   "Fix memory leak for extension uninstall dialog".

## Appendix: Sample output

**$ ./out/gn_Debug/browser_tests --gtest_filter=BrowserUiTest.Invoke**
```
Note: Google Test filter = BrowserUiTest.Invoke
[==========] Running 1 test from 1 test case.
[----------] Global test environment set-up.
[----------] 1 test from BrowserUiTest
[ RUN      ] BrowserUiTest.Invoke
[26879:775:0207/134949.118352:30434675...:INFO:browser_ui_browsertest.cc(46)
Pass one of the following after --ui=
        AppInfoDialogBrowserTest.InvokeUi_default
        AskGoogleForSuggestionsDialogTest.DISABLED_InvokeUi_default
        BluetoothChooserBrowserTest.InvokeUi_ConnectedBubble
        BluetoothChooserBrowserTest.InvokeUi_ConnectedModal
/* and many more */
[       OK ] BrowserUiTest.Invoke (0 ms)
[----------] 1 test from BrowserUiTest (0 ms total)
[----------] Global test environment tear-down
[==========] 1 test from 1 test case ran. (1 ms total)
[  PASSED  ] 1 test.
[1/1] BrowserUiTest.Invoke (334 ms)
SUCCESS: all tests passed.
```

**$ ./out/gn_Debug/browser_tests --gtest_filter=BrowserUiTest.Invoke
--ui=CardUnmaskPromptViewBrowserTest.InvokeUi_expired**

```
Note: Google Test filter = BrowserUiTest.Invoke
[==========] Running 1 test from 1 test case.
[----------] Global test environment set-up.
[----------] 1 test from BrowserUiTest
[ RUN      ] BrowserUiTest.Invoke
Note: Google Test filter = CardUnmaskPromptViewBrowserTest.InvokeDefault
[==========] Running 1 test from 1 test case.
[----------] Global test environment set-up.
[----------] 1 test from CardUnmaskPromptViewBrowserTest, where TypeParam =
[ RUN      ] CardUnmaskPromptViewBrowserTest.InvokeUi_expired
/* 7 lines of uninteresting log spam */
[       OK ] CardUnmaskPromptViewBrowserTest.InvokeUi_expired (1324 ms)
[----------] 1 test from CardUnmaskPromptViewBrowserTest (1324 ms total)
[----------] Global test environment tear-down
[==========] 1 test from 1 test case ran. (1325 ms total)
[  PASSED  ] 1 test.
[       OK ] BrowserUiTest.Invoke (1642 ms)
[----------] 1 test from BrowserUiTest (1642 ms total)
[----------] Global test environment tear-down
[==========] 1 test from 1 test case ran. (1642 ms total)
[  PASSED  ] 1 test.
[1/1] BrowserUiTest.Invoke (2111 ms)
SUCCESS: all tests passed.
```

**$ ./out/gn_Debug/browser_tests --gtest_filter=BrowserUiTest.Invoke
--ui=CardUnmaskPromptViewBrowserTest.InvokeUi_expired
--test-launcher-interactive**
```
/*
 * Output as above, except the test are not interleaved, and the browser window
 * should remain open until the UI is dismissed
 */
```

[chrome/browser/ui/test/test_browser_ui.h]: https://cs.chromium.org/chromium/src/chrome/browser/ui/test/test_browser_ui.h
[chrome/browser/ui/test/test_browser_dialog.h]: https://cs.chromium.org/chromium/src/chrome/browser/ui/test/test_browser_dialog.h
[chrome/browser/ui/ask_google_for_suggestions_dialog_browsertest.cc]: https://cs.chromium.org/chromium/src/chrome/browser/ui/ask_google_for_suggestions_dialog_browsertest.cc?l=18&q=ShowUi
[chrome/browser/infobars/infobars_browsertest.cc]: https://cs.chromium.org/chromium/src/chrome/browser/infobars/infobars_browsertest.cc?l=134&q=UiBrowserTest
[ExtensionBrowserTest]: https://cs.chromium.org/chromium/src/chrome/browser/extensions/extension_browsertest.h?q=extensionbrowsertest&l=40
', NULL, N'development', N'development/testing/test_browser_dialog', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'ResultDB', N'[TOC]

# Chromium Integration with ResultDB

ResultDB is a LUCI service for storing and retrieving test results. See also
its [public source] and [Google internal documentation]. As of Q4 2021, all
tests on Chrome/Chromium builders have their test results uploaded to ResultDB,
and nearly all pass-fail decisions on the builders are based on these results.
Consequently, any JSON output from a test no longer has little to no impact on
the results of the bots. (For example, if a test''s JSON say that there was a
failure but this isn''t similarly reflected in ResultDB, then the build _will not
fail._

## ResultDB API & ResultSink

All test harnesses are responsible for uploading their results to ResultDB. This
is most easily done via ResultSink (see [internal documentation]). ResultSink is
a local HTTP server that proxies requests to ResultDB''s backend. It can be
launched via the `rdb stream ...` command and listens on a port specified in a
file pointed to by the `LUCI_CONTEXT` environment variable. This server
currently runs in the background on all test bots.

On a machine with the server running, a test can report its results to ResultDB
by making JSON-formatted RPCs to the local HTTP ResultSink server. See
[ResultSink''s API] for more details.

## ResultSink integration/wrappers within Chromium

There are several libraries used within Chromium that have ResultSink
integration:

- **Web Tests**: Blink''s web tests upload their results through ResultSink via
  [test_result_sink.py].

- **typ**: Typ is a testing library used by performance benchmarks and GPU
  tests. It integrates with ResultSink in [result_sink.py].

- **//build/util/lib/results/**: [//build/util/lib/results/] contains a generic
  wrapper around ResultSink. This is used by both the Android and ChromeOS test
  runners to upload their results to ResultDB.

- **iOS test runner**: The iOS test runner has its own ResultSink integration in
  [result_sink_util.py].

- **result_adapter**: Most remaining tests use the `result_adapter` tool. See
  below for more details.

## result_adapter

[result_adapter] is a command-line tool that wraps a test invocation and will
automatically convert the test''s output JSON to the ResultSink format and
uploads those results to ResultDB via ResultSink. Known JSON formats include:

- `gtest` for the JSON generated by running GTests using the support code in
  //base/test/launcher/, specifically the `SaveSummaryAsJSON` function in
  [test_results_tracker.h].

- `json` for the JSON format described in [json_test_results_format.md]. Tests
  that can generate this type of JSON include Blink web tests and typ-supported
  tests.

Though it eased the migration of results into ResultDB, using result_adapter has
a few drawbacks:

- result_adapter uploads all results at once after the test invocation exits.
  If the test execution crashes partway through, ResultDB will not track any of
  the results that were successfully produced.

- result_adapter is limited by the JSON format of the test. It would be unable
  to use any new or advanced feature in ResultDB.

Consequently, it''s preferred when possible for new test types and new test
harnesses to integrate with ResultSink directly rather than using
result_adapter. But if circumstances make integration difficult (e.g. we don''t
have access to the test harness implementation) result_adapter can be needed.

### Specifying integration in //testing/buildbot/

The *.pyl spec files in [//testing/buildbot/] control what tests a given bot
runs. These testing specs also control how result_adapter is used. By default, a
`isolated_scripts` test will have result_adapter added using the `json`
output format, and a `gtest_tests` test will have result_adapter added using the
`gtest` output format. This can be overwritten using the
`has_native_resultdb_integration` [mixin] which will disable result_adapter for
that test. Additionally, a custom `result_format` can be specified for a test to
overwrite the expected format of the JSON: [example].

[public source]: https://source.chromium.org/chromium/infra/infra/+/main:go/src/go.chromium.org/luci/resultdb/
[Google internal documentation]: http://shortn/_bTdqm8VDXz
[internal documentation]: http://shortn/_zAbl5fa84c
[ResultSink''s API]: https://source.chromium.org/chromium/infra/infra/+/main:go/src/go.chromium.org/luci/resultdb/sink/proto/v1/sink.proto;drc=54f060e7452368ff982d9c66f2c1001bf4fa7394;l=24
[test_result_sink.py]: https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/tools/blinkpy/web_tests/controllers/test_result_sink.py
[result_sink.py]: https://source.chromium.org/chromium/chromium/src/+/main:third_party/catapult/third_party/typ/typ/result_sink.py
[//build/util/lib/results/]: https://source.chromium.org/chromium/chromium/src/+/main:build/util/lib/results/
[result_sink_util.py]: https://source.chromium.org/chromium/chromium/src/+/main:ios/build/bots/scripts/result_sink_util.py
[result_adapter]: https://source.chromium.org/chromium/infra/infra/+/main:go/src/infra/tools/result_adapter/
[test_results_tracker.h]: https://source.chromium.org/chromium/chromium/src/+/main:base/test/launcher/test_results_tracker.h;drc=96020cfd447cb285acfa1a96c37a67ed22fa2499;l=83
[json_test_results_format.md]: json_test_results_format.md
[//testing/buildbot/]: https://source.chromium.org/chromium/chromium/src/+/main:testing/buildbot/
[mixin]: https://source.chromium.org/chromium/chromium/src/+/main:testing/buildbot/mixins.pyl;drc=d0985a69618056e95d64b48803ca90e3ae6a6c77;l=453
[example]: https://source.chromium.org/chromium/chromium/src/+/main:testing/buildbot/test_suites.pyl;drc=9ef43df31342fb0fc854de5233b7170039028bc1;l=1499
', NULL, N'development', N'development/testing/resultdb', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'JSON Test Results Format', N'# The JSON Test Results Format

*** note
Warning: The JSON test result format no longer affects the pass-fail decisions
made by Chrome''s bots. All results are now fetched from ResultDB. For more
info, see [resultdb.md](resultdb.md).
***

The JSON Test Results Format is a generic file format we use to record the
results of each individual test in test run (whether the test is run on a bot,
or run locally).

[TOC]

## Introduction

We use these files on the bots in order to determine whether a test step had
any failing tests (using a separate file means that we don''t need to parse the
output of the test run, and hence the test can be tailored for human readability
as a result). We also upload the test results to dashboards like the
[Flakiness Dashboard](http://test-results.appspot.com).

The test format originated with the Blink web tests, but has since been
adopted by GTest-based tests and Python unittest-based tests, so we''ve
standardized on it for anything related to tracking test flakiness.

### Example

Here''s a very simple example for one Python test:

    % python mojo/tools/run_mojo_python_tests.py --write-full-results-to results.json mojom_tests.parse.ast_unittest.ASTTest.testNodeBase
    Running Python unit tests under mojo/public/tools/bindings/pylib ...
    .
    ----------------------------------------------------------------------
    Ran 1 test in 0.000s

    OK
    % cat results.json
    {
      "tests": {
        "mojom_tests": {
          "parse": {
            "ast_unittest": {
              "ASTTest": {
                "testNodeBase": {
                  "expected": "PASS",
                  "actual": "PASS",
                  "artifacts": {
                    "screenshot": ["screenshots/page.png"],
                  }
                }
              }
            }
          }
        }
      },
      "interrupted": false,
      "path_delimiter": ".",
      "version": 3,
      "seconds_since_epoch": 1406662283.764424,
      "num_failures_by_type": {
        "FAIL": 0,
        "PASS": 1
      },
      "artifact_types": {
        "screenshot": "image/png"
      }
    }



As you can see, the format consists of a one top level dictionary containing a
set of metadata fields describing the test run, plus a single `tests` key that
contains the results of every test run, structured in a hierarchical trie format
to reduce duplication of test suite names (as you can see from the deeply
hierarchical Python test name).

The file is strictly JSON-compliant. As a part of this, the fields in each
object may appear in any order.

## Top-level field names

| Field Name | Data Type | Description |
|------------|-----------|-------------|
| `interrupted` | boolean | **Required.** Whether the test run was interrupted and terminated early (either via the runner bailing out or the user hitting ctrl-C, etc.) If true, this indicates that not all of the tests in the suite were run and the results are at best incomplete and possibly totally invalid. |
| `num_failures_by_type` |  dict | **Required.** A summary of the totals of each result type. If a test was run more than once, only the first invocation''s result is included in the totals. Each key is one of the result types listed below. A missing result type is the same as being present and set to zero (0). |
| `path_delimiter` | string | **Optional, will be mandatory.** The separator string to use in between components of a tests name; normally "." for GTest- and Python-based tests and "/" for web tests; if not present, you should default to "/" for backwards-compatibility.  |
| `seconds_since_epoch` | float | **Required.** The start time of the test run expressed as a floating-point offset in seconds from the UNIX epoch. |
| `tests` | dict | **Required.** The actual trie of test results. Each directory or module component in the test name is a node in the trie, and the leaf contains the dict of per-test fields as described below. |
| `version` | integer | **Required.** Version of the file format. Current version is 3. |
| `artifact_types` | dict | **Optional. Required if any artifacts are present for any tests.** MIME Type information for artifacts in this json file. All artifacts with the same name must share the same MIME type.  |
| `artifact_permanent_location` | string | **Optional.** The URI of the root location where the artifacts are stored. If present, any artifact locations are taken to be relative to this location. Currently only the `gs://` scheme is supported. |
| `build_number` | string | **Optional.** If this test run was produced on a bot, this should be the build number of the run, e.g., "1234". |
| `builder_name` | string | **Optional.** If this test run was produced on a bot, this should be the builder name of the bot, e.g., "Linux Tests". |
| `metadata` | dict | **Optional.** It maps to a dictionary that contains all the key value pairs used as metadata. This dictionary also includes the tags, test name prefix and test expectations file paths used during a test run. |
| `chromium_revision` | string | **Optional.** The revision of the current Chromium checkout, if relevant, e.g. "356123". |
| `has_pretty_patch` | bool | **Optional, layout test specific, deprecated.** Whether the web tests'' output contains PrettyDiff-formatted diffs for test failures. |
| `has_wdiff` | bool | **Optional, layout test specific, deprecated.** Whether the web tests'' output contains wdiff-formatted diffs for test failures. |
| `layout_tests_dir` | string | **Optional, layout test specific.** Path to the web_tests directory for the test run (used so that we can link to the tests used in the run). |
| `pixel_tests_enabled` | bool | **Optional, layout test specific.** Whether the web tests'' were run with the --pixel-tests flag.  |
| `flag_name` | string | **Optional, layout test specific.** The flags used when running tests|
| `fixable` | integer | **Optional, deprecated.** The number of tests that were run but were expected to fail. |
| `num_flaky` | integer | **Optional, deprecated.** The number of tests that were run more than once and produced different results each time. |
| `num_passes` | integer | **Optional, deprecated.** The number of successful tests; equivalent to `num_failures_by_type["Pass"]` |
| `num_regressions` | integer | **Optional, deprecated.** The number of tests that produced results that were unexpected failures. |
| `skips` | integer | **Optional, deprecated.** The number of tests that were found but not run (tests should be listed in the trie with "expected" and "actual" values of `SKIP`). |

## Per-test fields

Each leaf of the `tests` trie contains a dict containing the results of a
particular test name. If a test is run multiple times, the dict contains the
results for each invocation in the `actual` field. Unless otherwise noted,
if the test is run multiple times, all of the other fields represent the
overall / final / last value. For example, if a test unexpectedly fails and
then is retried and passes, both `is_regression` and `is_unexpected` will be false).

|  Field Name | Data Type | Description |
|-------------|-----------|-------------|
|  `actual` | string | **Required.** An ordered space-separated list of the results the test actually produced. `FAIL PASS` means that a test was run twice, failed the first time, and then passed when it was retried. If a test produces multiple different results, then it was actually flaky during the run. |
|  `expected` | string | **Required.** An unordered space-separated list of the result types expected for the test, e.g. `FAIL PASS` means that a test is expected to either pass or fail. A test that contains multiple values is expected to be flaky. |
|  `artifacts` | dict | **Optional.** A dictionary describing test artifacts generated by the execution of the test. The dictionary maps the name of the artifact (`screenshot`, `crash_log`) to a list of relative locations of the artifact (`screenshot/page.png`, `logs/crash.txt`). Any ''/'' characters in the file paths are meant to be platform agnostic; tools will replace them with the appropriate per platform path separators. There is one entry in the list per test execution. If `artifact_permanent_location` is specified, then this location is relative to that path. Otherwise, the path is assumed to be relative to the location of the json file which contains this (i.e., `$ISOLATED_OUTDIR`). The actual locations of artifacts are implementation-defined by the test program and can follow any convention, since these entries will allow them to be looked up easily. |
|  `bugs` | string | **Optional.** A comma-separated list of URLs to bug database entries associated with each test. |
|  `shard` | int | **Optional.** The 0-based index of the shard that the test ran on, if the test suite was sharded across multiple bots. |
|  `is_flaky` | bool | **Optional.** If present and true, the test was run multiple times and produced more than one kind of result. If false (or if the key is not present at all), the test either only ran once or produced the same result every time. |
|  `is_regression` | bool | **Optional.** If present and true, the test failed unexpectedly. If false (or if the key is not present at all), the test either ran as expected or passed unexpectedly. |
|  `is_unexpected` | bool | **Optional.** If present and true, the test result was unexpected. This might include an unexpected pass, i.e., it is not necessarily a regression. If false (or if the key is not present at all), the test produced the expected result. |
|  `time` | float | **Optional.** If present, the time it took in seconds to execute the first invocation of the test. |
|  `times` | array of floats | **Optional.** If present, the times in seconds of each invocation of the test. |
|  `has_repaint_overlay` | bool | **Optional, web test specific.** If present and true, indicates that the test output contains the data needed to draw repaint overlays to help explain the results (only used in layout tests). |
|  `is_missing_audio` | bool | **Optional, we test specific.** If present and true, the test was supposed to have an audio baseline to compare against, and we didn''t find one. |
|  `is_missing_text` | bool | **Optional, web test specific.** If present and true, the test was supposed to have a text baseline to compare against, and we didn''t find one.  |
|  `is_missing_video` | bool | **Optional, web test specific.** If present and true, the test was supposed to have an image baseline to compare against and we didn''t find one. |
|  `is_testharness_test` | bool | **Optional, web test specific.** If present, indicates that the layout test was written using the w3c''s test harness and we don''t necessarily have any baselines to compare against. |
|  `is_slow_test` | bool | **Optional, web test specific.** If present and true, the test is expected to take longer than normal to run. |
|  `reftest_type` | string | **Optional, web test specific.** If present, one of `==` or `!=` to indicate that the test is a "reference test" and the results were expected to match the reference or not match the reference, respectively (only used in layout tests). |

## Test result types

Any test may fail in one of several different ways. There are a few generic
types of failures, and the web tests contain a few additional specialized
failure types.

|  Result type | Description |
|--------------|-------------|
|  `CRASH` | The test runner crashed during the test. |
|  `FAIL` | The test did not run as expected. |
|  `PASS` | The test ran as expected. |
|  `SKIP` | The test was not run. |
|  `TIMEOUT` | The test hung (did not complete) and was aborted. |
|  `AUDIO` | **Web test specific, deprecated.** The test is expected to produce audio output that doesn''t match the expected result. Normally you will see `FAIL` instead. |
|  `IMAGE` | **Web test specific, deprecated.** The test produces image (and possibly text output). The image output doesn''t match what we''d expect, but the text output, if present, does. Normally you will see `FAIL` instead. |
|  `IMAGE+TEXT` | **Web test specific, deprecated.** The test produces image and text output, both of which fail to match what we expect. Normally you will see `FAIL` instead. |
|  `LEAK` | **Web test specific, deprecated.** Memory leaks were detected during the test execution. |
|  `MISSING` | **Web test specific, deprecated.** The test completed but we could not find an expected baseline to compare against. |
|  `NEEDSREBASELINE` | **Web test specific, deprecated.** The expected test result is out of date and will be ignored (as above); the auto-rebaseline-bot will look for tests of this type and automatically update them. This should never show up as an `actual` result. |
|  `REBASELINE`  | **Web test specific, deprecated.** The expected test result is out of date and will be ignored (any result other than a crash or timeout will be considered as passing). This test result should only ever show up on local test runs, not on bots (it is forbidden to check in a TestExpectations file with this expectation). This should never show up as an "actual" result. |
|  `SLOW` | **Web test specific, deprecated.** The test is expected to take longer than normal to run. This should never appear as an `actual` result, but may (incorrectly) appear in the expected fields. |
|  `TEXT` | **Web test specific, deprecated.** The test is expected to produce a text-only failure (the image, if present, will match). Normally you will see `FAIL` instead. |

Unexpected results, failures, and regressions are different things.

An unexpected result is simply a result that didn''t appear in the `expected`
field. It may be used for tests that _pass_ unexpectedly, i.e. tests that
were expected to fail but passed. Such results should _not_ be considered
failures.

Anything other than `PASS`, `SKIP`, `SLOW`, or one of the REBASELINE types is
considered a failure.

A regression is a result that is both unexpected and a failure.

## `full_results.json` and `failing_results.json`

The web tests produce two different variants of the above file. The
`full_results.json` file matches the above definition and contains every test
executed in the run. The `failing_results.json` file contains just the tests
that produced unexpected results, so it is a subset of the `full_results.json`
data. The `failing_results.json` file is also in the JSONP format, so it can be
read via as a `<script>` tag from an html file run from the local filesystem
without falling prey to the same-origin restrictions for local files.  The
`failing_results.json` file is converted into JSONP by containing the JSON data
preceded by the string "ADD_RESULTS(" and followed by the string ");", so you
can extract the JSON data by stripping off that prefix and suffix.
', NULL, N'development', N'development/testing/json_test_results_format', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Web Platform Tests', N'# web-platform-tests

Interoperability between browsers is
[critical](https://www.chromium.org/blink/platform-predictability) to Chromium''s
mission of improving the web. We believe that leveraging and contributing to a
shared test suite is one of the most important tools in achieving
interoperability between browsers. The [web-platform-tests
repository](https://github.com/web-platform-tests/wpt) is the primary shared
test suite where all browser engines are collaborating.

Chromium has a 2-way import/export process with the upstream web-platform-tests
repository, where tests are imported into
[web_tests/external/wpt](../../third_party/blink/web_tests/external/wpt)
and any changes to the imported tests are also exported to web-platform-tests.

See https://web-platform-tests.org/ for general documentation on
web-platform-tests, including tips for writing and reviewing tests.

[TOC]

## Writing tests

To contribute changes to web-platform-tests, just commit your changes directly
to [web_tests/external/wpt](../../third_party/blink/web_tests/external/wpt)
and the changes will be automatically upstreamed within 24 hours.

Changes involving adding, removing or modifying tests can all be upstreamed.
Any changes outside of
[external/wpt](../../third_party/blink/web_tests/external/wpt) will not be
upstreamed, and any changes `*-expected.txt`, `OWNERS`, and `MANIFEST.json`,
will also not be upstreamed.

Running the web tests will automatically regenerate MANIFEST.json to pick up
any local modifications.

Most tests are written using testharness.js, see
[Writing Web Tests](./writing_web_tests.md) and
[Web Tests Tips](./web_tests_tips.md) for general guidelines.

### Write tests against specifications

Tests in web-platform-tests are expected to match behavior defined by the
relevant specification. In other words, all assertions that a test makes
should be derived from a specification''s normative requirements, and not go
beyond them. It is often necessary to change the specification to clarify what
is and isn''t required.

When implementation experience is needed to inform the specification work,
[tentative tests](https://web-platform-tests.org/writing-tests/file-names.html)
can be appropriate. It should be apparent in context why the test is tentative
and what needs to be resolved to make it non-tentative.

### Tests that require testing APIs

#### `testdriver.js`

[testdriver.js](https://web-platform-tests.org/writing-tests/testdriver.html)
provides a means to automate tests that cannot be written purely using web
platform APIs, similar to `internals.*` and `eventSender.*` in regular Blink
web tests.

If no testdriver.js API exists, check if it''s a
[known issue](https://github.com/web-platform-tests/wpt/labels/testdriver.js)
and otherwise consider filing a new issue. For instructions on how to add a new
testing API, see [WPT Test Automation for
Chromium](https://docs.google.com/document/d/18BpD41vyX1cFZ77CE0a_DJYlGpdvyLlx3pwXVRxUzvI/preview#)

#### MojoJS

Some specs may define testing APIs (e.g.
[WebUSB](https://wicg.github.io/webusb/test/)), which may be polyfilled with
internal API like [MojoJS](../../mojo/public/js/README.md).  MojoJS is only
allowed in WPT for this purpose. Please reach out to
blink-dev@chromium.org before following the process below for adding a new
test-only API:

 1. Create a full list of `*.mojom.m.js` files that you need, including all
    dependencies. Generated modules load dependencies recursively by default,
    so you can check the network panel of DevTools to see the full list of
    dependencies it loads.
 2. Check [linux-archive-rel.json](../../infra/archive_config/linux-archive-rel.json) and add any
    missing `*.mojom.m.js` files to the `mojojs.zip` archive. Globs are
    supported in `filename`. Do not copy Mojom bindings into WPT.
 3. Meanwhile in Chromium, you can create a helper for your WPT tests to do
    browser-specific setup using
    [test-only-api.js](../../third_party/blink/web_tests/external/wpt/resources/test-only-api.js).
    See
    [webxr_util.js](../../third_party/blink/web_tests/external/wpt/webxr/resources/webxr_util.js)
    as an example. You can write tests using this helper right away, but they
    will not work upstream (i.e. on https://wpt.fyi ) until your change in step
    2 is included in official channels, as `mojojs.zip` is built alongside with
    Chrome.

#### `wpt_automation`

An alternative to the above options is to write manual tests that are automated
with scripts from
[wpt_automation](../../third_party/blink/web_tests/external/wpt_automation).
Injection of JS in manual tests is determined by `loadAutomationScript` in
[testharnessreport.js](../../third_party/blink/web_tests/resources/testharnessreport.js).

Such tests still require case-by-case automation to run for other browser
engines, but are more valuable than purely manual tests.

Manual tests that have no automation are still imported, but skipped in
[NeverFixTests](../../third_party/blink/web_tests/NeverFixTests); see
[issue 738489](https://crbug.com/738489).

### Contribution process

Changes made in
[web_tests/external/wpt](../../third_party/blink/web_tests/external/wpt) are
[automatically exported to GitHub](#exporting-tests).

It''s still possible to make direct pull requests to web-platform-tests, see
https://web-platform-tests.org/writing-tests/github-intro.html.

### Adding new top-level directories

Entirely new top-level directories should generally be added upstream, since
that''s the only way to add an OWNERS file upstream. After adding a new top-level
directory upstream, you should add a line for it in `W3CImportExpectations`.

Adding the new directory (and `W3CImportExpectations` entry) in Chromium and
later adding an OWNERS file upstream also works.

### `wpt_internal`

It is sometimes desirable to write WPT tests that either test Chromium-specific
behaviors, or that cannot yet be upstreamed to WPT (e.g. because the spec is
very nascent). For these cases, we maintain a separate directory,
[wpt_internal](../../third_party/blink/web_tests/wpt_internal) that runs under the
WPT testing infrastructure (e.g. uses wptserve, etc), but which is not
upstreamed to WPT.

Please see the `wpt_internal`
[README](../../third_party/blink/web_tests/wpt_internal/README.md) for more details.

**Note**: A significant downside of `wpt_internal` is that your tests may be
broken by upstream changes to the resources scripts (e.g. `testharness.js`), as
`wpt_internal` does not use the forked version of `testharness.js` used by all
other non-`external/wpt` tests. Use of [new failure
notifications](#new-failure-notifications) is recommended to ensure you are
notified of breakages.

## Running tests

Same as Blink web tests, you can use
[`run_web_tests.py`](web_tests.md#running-the-tests) to run any WPT test. This
will run WPT tests in Content Shell. You can also run [`run_wpt_tests.py`](run_web_platform_tests.md) to
run WPT tests with Chrome.

One thing to note is that glob patterns for WPT tests are not yet supported.

See [Running WPT tests in Content Shell](web_tests_in_content_shell.md#Running-WPT-Tests-in-Content-Shell)
for debugging etc.

## Reviewing tests

Anyone who can review code and tests in Chromium can also review changes in
[external/wpt](../../third_party/blink/web_tests/external/wpt)
that will be automatically upstreamed. There will be no additional review in
web-platform-tests as part of the export process.

If upstream reviewers have feedback on the changes, discuss on the pull request
created during export, and if necessary work on a new pull request to iterate
until everyone is satisfied.

When reviewing tests, check that they match the relevant specification, which
may not fully match the implementation. See also
[Write tests against specifications](#Write-tests-against-specifications).

## Importing tests

Chromium has a [mirror](https://chromium.googlesource.com/external/w3c/web-platform-tests/)
of the GitHub repo and periodically imports a subset of the tests to
run as part of the regular Blink web test testing process.

The goals of this process are to be able to run web-platform-tests unmodified
locally just as easily as we can run the Blink tests, and ensure that we are
tracking tip-of-tree in the web-platform-tests repository as closely as
possible, and running as many of the tests as possible.

### Automatic import process

There is an automatic process for updating the Chromium copy of
web-platform-tests. The import is done by the builder [wpt-importer
builder][wpt-importer].

The easiest way to check the status of recent imports is to look at:

-   Recent logs on LUCI for [wpt-importer builder][wpt-importer]
-   Recent CLs created by [WPT
    Autoroller](https://chromium-review.googlesource.com/q/owner:wpt-autoroller%2540chops-service-accounts.iam.gserviceaccount.com).

The import jobs will generally be green if either there was nothing to do,
or a CL was successfully submitted.

For maintainers:

-   The source lives in
    [third_party/blink/tools/wpt_import.py](../../third_party/blink/tools/wpt_import.py).
-   If the importer starts misbehaving, it can be disabled by landing a
    [CL to skip the update step](https://crrev.com/c/1961906/).

### New failure notifications

The importer automatically file bugs against a component when imported changes
introduce failures as long as test owners did not choose to opt-out the failure
notification mechanism. This includes new tests that fail in Chromium, as well
as new failures introduced to an existing test. Test owners are encouraged to
create an `DIR_METADATA` file in the appropriate `external/wpt/` subdirectory
that contains at least the `buganizer_public.component_id` field, which the
importer will use to file bugs.
For example, `external/wpt/css/css-grid/DIR_METADATA` looks like:

```
buganizer_public {
  component_id: 1415957
}
team_email: "layout-dev@chromium.org"
```

When tests under `external/wpt/css/css-grid/` newly fail in a WPT import, the
importer will automatically file a bug against the `Chromium>Blink>Layout>Grid`
component in [issues.chromium.org](https://issues.chromium.org/issues), with
details of which tests failed and the outputs.
The importer will also copy `layout-dev@chromium.org` (the `team_email`) and any
`external/wpt/css/css-grid/OWNERS` on the bug.

Failing tests are grouped according to the most specific `DIR_METADATA` that
they roll up to.

To opt-out of this notification, add `wpt.notify` field set to `NO` to the
corresponding `DIR_METADATA`.
For example, the following `DIR_METADATA` will suppress notification from tests
under the located directory:

```
buganizer_public {
  component_id: 1415957
}
team_email: "layout-dev@chromium.org"
wpt {
  notify: NO
}
```

### Skipped tests (and how to re-enable them)

We control which tests are imported via a file called
[W3CImportExpectations](../../third_party/blink/web_tests/W3CImportExpectations),
which has a list of directories to skip while importing.

In addition to the directories and tests explicitly skipped there, tests may
also be skipped for a couple other reasons, e.g. if the file path is too long
for Windows. To check what files are skipped in import, check the recent logs
for [wpt-importer builder][wpt-importer].

If you wish to un-skip some of the directories currently skipped in
`W3CImportExpectations`, you can modify that file locally and commit it, and on
the next auto-import, the new tests should be imported.

If you want to import immediately (in order to try the tests out locally, etc)
you can also run `wpt-import`, but this is not required.

Remember your import might fail due to GitHub''s limit for unauthenticated
requests, so consider [passing your GitHub credentials](#GitHub-credentials) to
the script.

### Waterfall failures caused by automatic imports.

If there are new test failures that start after an auto-import,
there are several possible causes, including:

 1. New baselines for flaky tests were added (https://crbug.com/701234).
 2. Modified tests should have new results for non-Release builds but they weren''t added (https://crbug.com/725160).
 3. New baselines were added for tests with non-deterministic test results (https://crbug.com/705125).

Because these tests are imported from the Web Platform tests, it is better
to have them in the repository (and marked failing) than not, so prefer to
[add test expectations](web_test_expectations.md) rather than reverting.
However, if a huge number of tests are failing, please revert the CL so we
can fix it manually.

[wpt-importer]: https://ci.chromium.org/p/infra/builders/luci.infra.cron/wpt-importer

## Exporting tests

If you upload a CL with any changes in
[third_party/blink/web_tests/external/wpt](../../third_party/blink/web_tests/external/wpt),
once your CL is ready to submit the exporter will create a provisional pull request with
those changes in the [upstream WPT GitHub repository](https://github.com/web-platform-tests/wpt/).
The exporter runs on [wpt-exporter builder][wpt-exporter].

Once you''re ready to land your CL, please follow the link posted by the bot and
check the status of the required checks of the GitHub PR. If it''s green, go
ahead landing your CL and the exporter will automatically merge the PR.

If GitHub status is red on the PR, please try to resolve the failures before
merging. If you run into any issues, or if you have a CL with WPT changes that
the exporter did not pick up, please reach out to blink-dev@chromium.org.

Additional things to note:

-   CLs that change over 1000 files will not be exported.
-   All PRs use the
    [`chromium-export`](https://github.com/web-platform-tests/wpt/pulls?utf8=%E2%9C%93&q=is%3Apr%20label%3Achromium-export) label.
-   All PRs for CLs that haven''t yet been landed in Chromium also use the
    [`do not merge yet`](https://github.com/web-platform-tests/wpt/pulls?q=is%3Apr+is%3Aopen+label%3A%22do+not+merge+yet%22) label.
-   The exporter cannot create upstream PRs for in-flight CLs with binary files
    (e.g. webm files). An export PR will still be made after the CL lands.

### Will the exported commits be linked to my GitHub profile?

The email you commit with in Chromium will be the author of the commit on
GitHub. You can [add it as a secondary address on your GitHub
account](https://help.github.com/articles/adding-an-email-address-to-your-github-account/)
to link your exported commits to your GitHub profile.

If you are a Googler, you can also register your GitHub account at go/github,
making it easier for other Googlers to find you.

### What if there are conflicts?

This cannot be avoided entirely as the two repositories are independent, but
should be rare with frequent imports and exports. When it does happen, manual
intervention will be needed and in non-trivial cases you may be asked to help
resolve the conflict.

[wpt-exporter]: https://ci.chromium.org/p/infra/builders/luci.infra.cron/wpt-exporter

## Notes for WPT infra maintainers

### Importer

#### Rubber-Stamper bot

To allow the importer to land CLs without human intervention, it utilizes the
[Rubber-Stamper
bot](https://chromium.googlesource.com/infra/infra/+/refs/heads/main/go/src/infra/appengine/rubber-stamper/README.md)
to approve import CLs.

Adding the Rubber-Stamper as a reviewer is one of the last steps the importer
takes, once tests have been rebaselined and the CQ passes. If the Rubber-Stamper
cannot approve a CL, it will leave a comment on the CL explaining why - this
will also cause the importer to go red.

![Rubber-Stamber bot rejecting a CL](images/wpt_import_rubber_stamper_reject.png)

There are two possibilities when the Rubber-Stamper rejects an import: either it
is a valid rejection, because the import changes code files (`.py`, `.bat`,
`.sh`), or it is invalid and we''re missing an allowlist rule for a file the
importer is allowed to modify.

For valid rejections, it is the job of the rotation sheriff to land the CL
manually. You need to un-abandon the import, `CR+1` it yourself, and `CQ+2` it.
If you don''t have permission to do that (e.g. are not a committer), contact
blink-dev@chromium.org.

For invalid rejections, message blink-dev@chromium.org or add an exception
rule yourself. [This is an example
CL](https://chrome-internal-review.googlesource.com/c/infradata/config/+/3608170)
that adds an exception rule. (Note that you need internal access to access this
repository).

#### Manual import

To pull the latest versions of the tests that are currently being imported, you
can also directly invoke the
[wpt-import](../../third_party/blink/tools/wpt_import.py) script.

That script will pull the latest version of the tests from our mirrors of the
upstream repositories. If any new versions of tests are found, they will be
committed locally to your local repository. You may then upload the changes.

Remember your import might fail due to GitHub''s limit for unauthenticated
requests, so consider [passing your GitHub credentials](#GitHub-credentials) to
the script.

### Exporter

-   The source lives in
    [third_party/blink/tools/wpt_export.py](../../third_party/blink/tools/wpt_export.py).
-   If the exporter starts misbehaving (for example, creating the same PR over
    and over again), put it in "dry run" mode by landing [this
    CL](https://crrev.com/c/462381/).

### GitHub credentials

When manually running the `wpt-import` and `wpt-export` scripts, several
requests are made to GitHub to query the status of pull requests, look for
existing exported commits etc. GitHub has a [fairly
low](https://developer.github.com/v3/#rate-limiting) request limit for
unauthenticated requests, so it is recommended that you let `wpt-export` and
`wpt-import` use your GitHub credentials when sending requests:

 1. Generate a new [personal access token](https://github.com/settings/tokens)
 1. Set up your credentials by either:
     * Setting the `GH_USER` environment variable to your GitHub user name
       and the `GH_TOKEN` environment variable to the access token you have
       just created **or**
     * Creating a JSON file with two keys: `GH_USER`, your GitHub user name,
       and `GH_TOKEN`, the access token you have just generated. After that,
       pass `--credentials-json <path-to-json>` to `wpt-export` and
       `wpt-import`.

### Debugging failed web platform tests

This section explains the way to debug web platform tests.
Please build `blink_tests` before running commands below.
It is explained in [Running Web Tests](./web_tests.md#running-web-tests).

#### Running test(s)

The way to run web tests is explained in [Running the
Tests](./web_tests.md#running-the-tests).

Assume that you are writing the test named `wpt_internal/fake/foobar.html`.
You may want to run only the tests and you do not want to run all tests under
`wpt_internal/fake`.  The following command narrows down the test to only
`wpt_internal/fake/foobar.html`.

```bash
third_party/blink/tools/run_web_tests.py -t Default \
third_party/blink/web_tests/wpt_internal/fake/foobar.html
```

#### Logging

During the debug, you may want to log what happens during the test.
You can use `console.log` in JavaScript to log arbitrary strings.

```
e.g.
console.log(''fake has been executed.'');
console.log(''foo='' + foo);
```

Logs are written under `$root_build_dir/layout-test-results`.
If you have tested `wpt_internal/fake/foobar.html`, the log will be stored in
`$root_build_dir/layout-test-results/wpt_internal/fake/foobar-stderr.txt`.
You can change output directory with `--results-directory=<output directory>`.

#### Checking HTTP servers

For some test cases, you may use .headers file to set arbitrary HTTP headers.
To verify what is set to headers, you can run an HTTP server used for WPT
by yourself. The following command starts the HTTP server for you:

```bash
third_party/blink/tools/run_blink_wptserve.py
```

To see headers returned by the server, you can use `curl -v`.
`curl` will show headers in stderr. You may want to use `|& less` to
see output if it is too long.

```bash
curl -v http://localhost:8081/wpt_internal/fake/foobar.html |& less
```

#### Debugging with a debugger

You are able to debug the inside of Chromium with a debugger for particular
WPT tests. Refer to [Running web tests using the content shell](https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/testing/web_tests_in_content_shell.md)
for details.
', NULL, N'development', N'development/testing/web_platform_tests', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Running WPT', N'# Running Web Platform Tests with run_wpt_tests.py

`run_web_tests.py` runs web tests with content shell through [protocol mode].
See [web_tests.md](web_tests.md) for details.
`run_wpt_tests.py` is a WebDriver-based alternative that can run [web platform
tests] with [Chrome], [headless shell], Chrome Android, and WebView.
This document explains how to use `run_wpt_tests.py` in these scenarios.

[web platform tests]: web_platform_tests.md
[Chrome]: /chrome
[headless shell]: /headless

[TOC]

## Running Web Platform Tests for Desktop Platforms

On Linux, macOS, and Windows, `run_wpt_tests.py` supports testing with [Chrome]
or [headless shell].
Chrome is closer to the binary Google ships to end users, but is generally
slower.
Headless shell is a lightweight alternative that suffices for testing features
implemented entirely in Blink.

### Running Tests Locally

First, you will need to build the `blink_tests` target as you were running web tests
before. This will build `headless_shell`, `chrome`, `chromedriver`, `content_shell`
and all other needed binaries to run web tests and WPTs.

```bash
autoninja -C out/Default blink_tests
```

Once the build is done, running tests is very similar to how you would run
tests with `run_web_tests.py`.
For example, to run all tests under `external/wpt/html/dom`, run:

```bash
third_party/blink/tools/run_wpt_tests.py --target=Default --product=headless_shell external/wpt/html/dom
```

`--product` (or `-p`) selects which browser to test with.
Supported values are:

* `headless_shell` (default if `--product` is not specified)
* `chrome`
* `chrome_android` (aliased as `clank`; see
  [additional instructions](#Running-Web-Platform-Tests-on-Android))
* `android_webview` (aliased as `webview`; see
  [additional instructions](#Running-Web-Platform-Tests-on-Android))

Also, consider using `-v` to get browser logs.
It can be provided multiple times to increase verbosity.

`run_wpt_tests.py --help` shows a full description of `run_wpt_tests.py`''s CLI,
which resembles that of `run_web_tests.py`.

### Running Tests in CQ/CI

To satisfy different testing requirements, WPT coverage in CQ/CI is partitioned
between suites that target different `//content` embedders:

Suite Name | Browser Under Test | Harness | Tests Run
--- | --- | --- | ---
`headless_shell_wpt_tests` | `headless_shell` | `run_wpt_tests.py` | The default test suite for WPTs if not specified otherwise.
`chrome_wpt_tests` | `chrome --headless=new` | `run_wpt_tests.py` | Tests that depend on the `//chrome` layer. Can be slow, so prefer `headless_shell` testing if possible.
`blink_wpt_tests` | `content_shell --run-web-tests` | `run_web_tests.py` | Tests under [internal WPTs] plus any public WPTs not migrated yet.

To avoid redundant coverage, each WPT should run in exactly one suite listed
above.
The [`chrome.filter`][1] file lists tests that `chrome_wpt_tests` should run,
and that `headless_shell_wpt_tests` and `blink_wpt_tests` should skip.
[`content_shell.filter`][2] file lists tests that currently run in `blink_wpt_tests`,
and will be removed once it only contains tests under `wpt_internal`. Tests
not listed in either file run in `headless_shell_wpt_tests` by default.

*** note
Running tests in `blink_wpt_tests` is discouraged because `run_web_tests.py`
doesn''t drive tests through standard WebDriver endpoints.
This can cause `blink_wpt_tests` results to diverge from the Chrome results
published to [wpt.fyi]. We should generally not add new tests to
content_shell.filter.
***

[internal WPTs]: /third_party/blink/web_tests/wpt_internal

### Test Expectations and Baselines

To suppress failures, `run_wpt_tests.py` uses the [same `*-expected.txt` and
TestExpectations files](web_test_expectations.md) that `run_web_tests.py` uses.

### Running webdriver tests with Chrome

[wdspec tests] are a subset of WPT that verifies conformance to the WebDriver
specification.
`run_wpt_tests.py` can run wdspec tests like any other WPT:

```bash
third_party/blink/tools/run_wpt_tests.py -t Default -p chrome \
  external/wpt/webdriver/tests/classic/find_element/find.py
```

On the bots, the `webdriver_wpt_tests` suite runs wdspec tests separately from
the other WPT types.
The `linux-blink-rel` builder can provide results for rebaselining.

[wdspec tests]: https://web-platform-tests.org/writing-tests/wdspec.html

## Running Web Platform Tests on Android

See [here](./run_web_platform_tests_on_android.md) for Android specific instructions.

## Debugging Support

### Text-Based Debuggers

To interactively debug WPTs, prefix the `run_wpt_tests.py` command with
[`debug_renderer`][debug renderer] to attach a debugger to a desired renderer.

For other use cases, see [these debugging tips].

[these debugging tips]: /docs/linux/debugging.md

## FAQ

* Do headless shell and Chrome support MojoJS bindings?
    * Yes.
      `run_wpt_tests.py` enables the `MojoJS` and `MojoJSTest` features and
      serves `//out/<target>/gen/` as `/gen/` in wptserve.
      However, in the public WPT suite, testdriver.js APIs must be backed by
      fully-specified testing APIs (preferably implemented with WebDriver or
      alternatively with MojoJS). Tests that rely on unspecified testing APIs
      cannot be put in WPT, but may live in chromium''s own wpt_internal.
      See https://github.com/web-platform-tests/rfcs/issues/172 for additional
      discussion.

## Known Issues

The [`wptrunner-migration`
hostlist](https://issues.chromium.org/hotlists/6224346) tracks test results
where headless shell and content shell differ.
For runner bugs and feature requests, please file [an issue against
`Blink>Infra`](https://issues.chromium.org/issues/new?component=1456928&template=1923166).

[protocol mode]: /content/web_test/browser/test_info_extractor.h
[debug renderer]: /third_party/blink/tools/debug_renderer
[wpt.fyi]: https://wpt.fyi/results/?label=experimental&label=master&aligned

[1]: /third_party/blink/web_tests/TestLists/chrome.filter
[2]: /third_party/blink/web_tests/TestLists/content_shell.filter
[3]: writing_web_tests.md#Relying-on-Blink_Specific-Testing-APIs
', NULL, N'development', N'development/testing/run_web_platform_tests', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'WPT on Android', N'# Running Web Platform Tests on Android

## Overview

This document provides a guide to running Web Platform Tests on Android.

For general instruction for running the Web Platform Tests, you should read
[Running Web Platform Tests with run_wpt_tests.py](./run_web_platform_tests.md).

[TOC]

## Initial Setup

Please follow the steps at [Checking out and building Chromium for Android
](/docs/android_build_instructions.md) to
setup your local environment. Once that is done, you need to build one of the
following targets:

```bash
autoninja -C out/Default chrome_public_wpt        # For testing with Chrome Android
autoninja -C out/Default trichrome_webview_wpt_64 # For testing with WebView
```

## Running the Tests

Once you have Chrome Android/WebView and `chromedriver` built, you can launch
`run_wpt_tests.py` to run WPTs. You can either run the tests on an Android
emulator or a real Android device.

Note: You can enable [Incremental Install](/build/android/incremental_install/README.md)
for Chrome Android by setting `incremental_install = True` in your `args.gn`
file.

This will cause the test harness to use the build directory''s incremental
installation script instead of the default browser APK.

### Running WPTs on an Android emulator

You will need to follow the steps in
[Using an Android Emulator](/docs/android_emulator.md) to be ready to run the
Android Emulator. Passing the `--avd-config` option to `run_wpt_tests.py` will
launch an emulator that will be shut down after running the tests.

The example below runs `external/wpt/badging/badge-success.https.html` in Chrome
Android on Android 13:

```bash
third_party/blink/tools/run_wpt_tests.py \
  -t Default \
  -p clank \
  --avd-config=tools/android/avd/proto/android_33_google_apis_x64.textpb \
  external/wpt/badging/badge-success.https.html
```

* `-t Default`: Use the build in `//out/Default/`
* `-p clank`: Runs the tests using Chrome for Android (clank).
* `--avd-config=tools/.../android_33_google_apis_x64.textpb`: Runs the tests on
Android 13 emulator (Google API 33).

To run the example in WebView:

```bash
$ third_party/blink/tools/run_wpt_tests.py \
  -t Default \
  -p android_webview \
  --webview-provider out/Default/apks/TrichromeWebView64.apk \
  --additional-apk out/Default/apks/TrichromeLibrary64.apk \
  --avd-config=tools/android/avd/proto/android_33_google_apis_x64.textpb \
  external/wpt/badging/badge-success.https.html
```

* `-p webview`: Runs the tests using WebView.
* `--webview-provider out/.../TrichromeWebView64.apk`: Specify
TrichromeWebView64 as WebView APK.
* `--additional-apk out/.../TrichromeLibrary64.apk`: Install TrichromeLibrary64
needed for the WebView APK after Android 10 (see [WebView Channels](/android_webview/docs/channels.md)).

Alternatively, you can launch the emulator yourself and `run_wpt_tests.py` will
detect and connect to the emulator and run WPTs with it. This can save you the
time to repeatedly launch the emulator. The commands below show how this works.

```bash
$ tools/android/avd/avd.py start \
  --avd-config=tools/android/avd/proto/android_33_google_apis_x64.textpb
$ third_party/blink/tools/run_wpt_tests.py \
  -t Default \
  -p clank \
  external/wpt/badging/badge-success.https.html
```

### Running WPTs on a real Android device

`run_wpt_tests.py` should be able to work with a real device as long as the
device can be found by `adb devices`. You will need to make sure the ABI matches
and these [steps
](/docs/android_build_instructions.md#installing-and-running-chromium-on-a-device)
are followed.

### Running Tests in CQ/CI

The builder `android-chrome-13-x64-wpt-android-specific` and
`android-webview-13-x64-wpt-android-specific` builders run tests specified by
the [`android.filter`](/third_party/blink/web_tests/TestLists/android.filter)
file, which tests Android-specific behaviors. Developers can add additional
tests to the list when necessary.

To satisfy different testing requirements, WPT coverage in CQ/CI is partitioned
between suites that target different `//content` embedders:

Suite Name | Browser Under Test | Harness | Tests Run
--- | --- | --- | ---
`android_blink_wpt_tests` | `chrome_android` | `run_wpt_tests.py` | Tests listed in [`android.filter`](#running-tests-in-cqci).
`webview_blink_wpt_tests` | `android_webview` | `run_wpt_tests.py` | Tests listed in [`android.filter`](#running-tests-in-cqci).

## Test expectations and Baselines

The
[MobileTestExpectations](../../third_party/blink/web_tests/MobileTestExpectations)
file contains the list of all known Chrome Android and Chrome WebView specific
test failures, and it inherits or overrides test expectations from the default
[TestExpectations](../../third_party/blink/web_tests/TestExpectations) file.

For baselines:
* Chrome Android specific baselines reside at
  `third_party/blink/web_tests/platform/android`, and fall back to
  `third_party/blink/web_tests/platform/linux`.
* WebView specific baselines reside at
  `third_party/blink/web_tests/platform/webview`, and fall back to
  `third_party/blink/web_tests/platform/linux`.

To update baselines:
1. Trigger tryjob(s)
  * For Chrome Androids: trigger `android-chrome-13-x64-wpt-android-specific`
  * For WebView: trigger `android-webview-13-x64-wpt-android-specific`
2. Run [the rebaseline tool](./web_test_expectations.md#How-to-rebaseline) after
  the results are ready.

## Known Issues

For runner bugs and feature requests, please file [an issue against
`Blink>Infra`
](https://issues.chromium.org/issues/new?component=1456928&template=1923166).
', NULL, N'development', N'development/testing/run_web_platform_tests_on_android', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'WPT Flake Addressing', N'# Addressing Flaky WPTs

This document provides tips and tricks for reproducing and debugging flakes in
[Web Platform Tests](web_platform_tests.md) (WPTs). As WPTs are a form of Web
Test, you may also wish to refer to the documentation on [Addressing Flaky Web
Tests](web_tests_addressing_flake.md).

## Debugging flaky WPTs

See also the documentation in [Addressing Flaky Web
Tests](web_tests_addressing_flake.md#Debugging-flaky-Web-Tests).

### Loading WPT tests directly in content\_shell

WPT tests have to be loaded from a server, `wptserve`, to run properly. In a
terminal, run:

```
./third_party/blink/tools/run_blink_wptserve.py
```

This will start the necessary server(s), and print the ports they are listening
on. Most tests can just be loaded over the main HTTP server (usually
`http://localhost:8001`), although some may require using the HTTPS server
instead.

To load a WPT test in content\_shell, run:

```
out/Default/content_shell http://localhost:8001/path/to/test.html
```

Here, the `path/to/test.html` is relative to the root of
`third_party/blink/web_tests/external/wpt`, e.g. `dom/historical.html`.

**Caveat**: As with all Web Tests, running `content_shell` like this is not
equivalent to what `run_web_tests.py` runs. See the same section in [Addressing
Flaky Web
Tests](web_tests_addressing_flake.md#Loading-the-test-directly-in-content_shell)
for more details and some suggestions. In addition to that list, some WPTs
(usually security-related) also expect a real domain and may behave differently
when loaded from localhost.
', NULL, N'development', N'development/testing/web_platform_tests_addressing_flake', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Web Tests Overview', N'# Web Tests (formerly known as "Layout Tests" or "LayoutTests")

Web tests are used by Blink to test many components, including but not
limited to layout and rendering. In general, web tests involve loading pages
in a test renderer (`content_shell`) and comparing the rendered output or
JavaScript output against an expected output file.

This document covers running and debugging existing web tests. See the
[Writing Web Tests documentation](./writing_web_tests.md) if you find
yourself writing web tests.

Note that we changed the term "layout tests" to "web tests".
Please assume these terms mean the identical stuff. We also call it as
"WebKit tests" and "WebKit layout tests".

["Web platform tests"](./web_platform_tests.md) (WPT) are the preferred form of
web tests and are located at
[web_tests/external/wpt](/third_party/blink/web_tests/external/wpt).
Tests that should work across browsers go there. Other directories are for
Chrome-specific tests only.

Note: if you are looking for a guide for the Web Platform Test, you should read
["Web platform tests"](./web_platform_tests.md) (WPT). This document does not
cover WPT specific features/behaviors.

Note: if you are looking for a guide for running the Web Platform Tests with
Chrome, Chrome Android or WebView, you should read ["Running Web Platform Tests with run_wpt_tests.py"](./run_web_platform_tests.md).

[TOC]

## Running Web Tests

### Supported Platforms

* Linux
* MacOS
* Windows
* Fuchsia

Android is [not supported](https://crbug.com/567947).

### Initial Setup

Before you can run the web tests, you need to build the `blink_tests` target
to get `content_shell` and all of the other needed binaries.

```bash
autoninja -C out/Default blink_tests
```

On **Mac**, you probably want to strip the content_shell binary before starting
the tests. If you don''t, you''ll have 5-10 running concurrently, all stuck being
examined by the OS crash reporter. This may cause other failures like timeouts
where they normally don''t occur.

```bash
strip ./out/Default/Content\ Shell.app/Contents/MacOS/Content\ Shell
```

### Running the Tests

The test runner script is in `third_party/blink/tools/run_web_tests.py`.

To specify which build directory to use (e.g. out/Default, etc.)
you should pass the `-t` or `--target` parameter. If no directory is specified,
`out/Release` will be used. To use the built-in `out/Default`, use:

```bash
third_party/blink/tools/run_web_tests.py -t Default
```

*** promo
* Windows users need to use `third_party\blink\tools\run_web_tests.bat` instead.
* Linux users should not use `testing/xvfb.py`; `run_web_tests.py` manages Xvfb
  itself.
***

Tests marked as `[ Skip ]` in
[TestExpectations](../../third_party/blink/web_tests/TestExpectations)
won''t be run by default, generally because they cause some intractable tool error.
To force one of them to be run, either rename that file or specify the skipped
test on the command line (see below) or in a file specified with --test-list
(however, --skip=always can make the tests marked as `[ Skip ]` always skipped).
Read the [Web Test Expectations documentation](./web_test_expectations.md) to
learn more about TestExpectations and related files.

*** promo
Currently only the tests listed in
[Default.txt](../../third_party/blink/web_tests/TestLists/Default.txt) are run
on the Fuchsia bots, since running all web tests takes too long on Fuchshia.
Most developers focus their Blink testing on Linux. We rely on the fact that the
Linux and Fuchsia behavior is nearly identical for scenarios outside those
covered by the smoke tests.
***

*** promo
Similar to Fuchsia''s case, the tests listed in [Mac.txt]
(../../third_party/blink/web_tests/TestLists/Mac.txt)
are run on older mac version bots. By doing this we reduced the resources needed to run
the tests. This relies on the fact that the majority of web tests will behavior similarly on
different mac versions.
***

To run only some of the tests, specify their directories or filenames as
arguments to `run_web_tests.py` relative to the web test directory
(`src/third_party/blink/web_tests`). For example, to run the fast form tests,
use:

```bash
third_party/blink/tools/run_web_tests.py fast/forms
```

Or you could use the following shorthand:

```bash
third_party/blink/tools/run_web_tests.py fast/fo\*
```

*** promo
Example: To run the web tests with a debug build of `content_shell`, but only
test the SVG tests and run pixel tests, you would run:

```bash
third_party/blink/tools/run_web_tests.py -t Default svg
```
***

As a final quick-but-less-robust alternative, you can also just use the
content_shell executable to run specific tests by using (example on Windows):

```bash
out\Default\content_shell.exe --run-web-tests <url>|<full_test_source_path>|<relative_test_path>
```

as in:

```bash
out\Default\content_shell.exe --run-web-tests \
    c:\chrome\src\third_party\blink\web_tests\fast\forms\001.html
```
or

```bash
out\Default\content_shell.exe --run-web-tests fast\forms\001.html
```

but this requires a manual diff against expected results, because the shell
doesn''t do it for you. It also just dumps the text result only (as the dump of
pixels and audio binary data is not human readable).
See [Running Web Tests Using the Content Shell](./web_tests_in_content_shell.md)
for more details of running `content_shell`.

To see a complete list of arguments supported, run:

```bash
third_party/blink/tools/run_web_tests.py --help
```

*** note
**Linux Note:** We try to match the Windows render tree output exactly by
matching font metrics and widget metrics. If there''s a difference in the render
tree output, we should see if we can avoid rebaselining by improving our font
metrics. For additional information on Linux web tests, please see
[docs/web_tests_linux.md](./web_tests_linux.md).
***

*** note
**Mac Note:** While the tests are running, a bunch of Appearance settings are
overridden for you so the right type of scroll bars, colors, etc. are used.
Your main display''s "Color Profile" is also changed to make sure color
correction by ColorSync matches what is expected in the pixel tests. The change
is noticeable, how much depends on the normal level of correction for your
display. The tests do their best to restore your setting when done, but if
you''re left in the wrong state, you can manually reset it by going to
System Preferences → Displays → Color and selecting the "right" value.
***

### Test Harness Options

This script has a lot of command line flags. You can pass `--help` to the script
to see a full list of options. A few of the most useful options are below:

| Option                      | Meaning |
|:----------------------------|:--------------------------------------------------|
| `--debug`                   | Run the debug build of the test shell (default is release). Equivalent to `-t Debug` |
| `--nocheck-sys-deps`        | Don''t check system dependencies; this allows faster iteration. |
| `--verbose`                 |	Produce more verbose output, including a list of tests that pass. |
| `--reset-results`           |	Overwrite the current baselines (`-expected.{png`&#124;`txt`&#124;`wav}` files) with actual results, or create new baselines if there are no existing baselines. |
| `--fully-parallel`          | Run tests in parallel using as many child processes as the system has cores. |
| `--driver-logging`          | Print C++ logs (LOG(WARNING), etc).  |

## Success and Failure

A test succeeds when its output matches the pre-defined expected results. If any
tests fail, the test script will place the actual generated results, along with
a diff of the actual and expected results, into
`src/out/Default/layout-test-results/`, and by default launch a browser with a
summary and link to the results/diffs.

The expected results for tests are in the
`src/third_party/blink/web_tests/platform` or alongside their respective
tests.

*** note
Tests which use [testharness.js](https://github.com/w3c/testharness.js/)
do not have expected result files if all test cases pass.
***

A test that runs but produces the wrong output is marked as "failed", one that
causes the test shell to crash is marked as "crashed", and one that takes longer
than a certain amount of time to complete is aborted and marked as "timed out".
A row of dots in the script''s output indicates one or more tests that passed.

## Test expectations

The
[TestExpectations](../../third_party/blink/web_tests/TestExpectations) file (and related
files) contains the list of all known web test failures. See the
[Web Test Expectations documentation](./web_test_expectations.md) for more
on this.

## Testing Runtime Flags

There are two ways to run web tests with additional command-line arguments:

### --flag-specific

```bash
third_party/blink/tools/run_web_tests.py --flag-specific=blocking-repaint
```
It requires that `web_tests/FlagSpecificConfig` contains an entry like:

```json
{
  "name": "blocking-repaint",
  "args": ["--blocking-repaint", "--another-flag"]
}
```

This tells the test harness to pass `--blocking-repaint --another-flag` to the
content_shell binary.

It will also look for flag-specific expectations in
`web_tests/FlagExpectations/blocking-repaint`, if this file exists. The
suppressions in this file override the main TestExpectations files.
However, `[ Slow ]` in either flag-specific expectations or base expectations
is always merged into the used expectations.

It will also look for baselines in `web_tests/flag-specific/blocking-repaint`.
The baselines in this directory override the fallback baselines.

*** note
[BUILD.gn](../../BUILD.gn) assumes flag-specific builders always runs on linux bots, so
flag-specific test expectations and baselines are only downloaded to linux bots.
If you need run flag-specific builders on other platforms, please update
BUILD.gn to download flag-specific related data to that platform.
***

You can also use `--additional-driver-flag` to specify additional command-line
arguments to content_shell, but the test harness won''t use any flag-specific
test expectations or baselines.

### Virtual test suites

A *virtual test suite* can be defined in
[web_tests/VirtualTestSuites](../../third_party/blink/web_tests/VirtualTestSuites),
to run a subset of web tests with additional flags, with
`virtual/<prefix>/...` in their paths. The tests can be virtual tests that
map to real base tests (directories or files) whose paths match any of the
specified bases, or any real tests under `web_tests/virtual/<prefix>/`
directory. For example, you could test a (hypothetical) new mode for
repainting using the following virtual test suite:

```json
{
  "prefix": "blocking_repaint",
  "platforms": ["Linux", "Mac", "Win"],
  "bases": ["compositing", "fast/repaint"],
  "args": ["--blocking-repaint"]
}
```

This will create new "virtual" tests of the form
`virtual/blocking_repaint/compositing/...` and
`virtual/blocking_repaint/fast/repaint/...` which correspond to the files
under `web_tests/compositing` and `web_tests/fast/repaint`, respectively,
and pass `--blocking-repaint` to `content_shell` when they are run.

Note that you can run the tests with the following command line:

```bash
third_party/blink/tools/run_web_tests.py virtual/blocking_repaint/compositing \
  virtual/blocking_repaint/fast/repaint
```

These virtual tests exist in addition to the original `compositing/...` and
`fast/repaint/...` tests. They can have their own expectations in
`web_tests/TestExpectations`, and their own baselines. The test harness will
use the non-virtual expectations and baselines as a fallback. If a virtual
test has its own expectations, they will override all non-virtual
expectations. Otherwise the non-virtual expectations will be used. However,
`[ Slow ]` in either virtual or non-virtual expectations is always merged
into the used expectations. If a virtual test is expected to pass while the
non-virtual test is expected to fail, you need to add an explicit `[ Pass ]`
entry for the virtual test.

This will also let any real tests under `web_tests/virtual/blocking_repaint`
directory run with the `--blocking-repaint` flag.

The "platforms" configuration can be used to skip tests on some platforms. If
a virtual test suites uses more than 5% of total test time, we should consider
to skip the test suites on some platforms.

The "prefix" value should be unique. Multiple directories with the same flags
should be listed in the same "bases" list. The "bases" list can be empty,
in case that we just want to run the real tests under `virtual/<prefix>`
with the flags without creating any virtual tests.

A virtual test suite can have an optional `exclusive_tests` field to specify
all (with `"ALL"`) or a subset of `bases` tests that will be exclusively run
under this virtual suite. The specified base tests will be skipped. Corresponding
virtual tests under other virtual suites that don''t specify the tests in their
`exclusive_tests` list will be skipped, too. For example (unrelated fields
are omitted):

```json
{
  "prefix": "v1",
  "bases": ["a"],
}
{
  "prefix": "v2",
  "bases": ["a/a1", "a/a2"],
  "exclusive_tests": "ALL",
}
{
  "prefix": "v3",
  "bases": ["a"],
  "exclusive_tests": ["a/a1"],
}
```

Suppose there are directories `a/a1`, `a/a2` and `a/a3`, we will run the
following tests:

|      Suite |   a/a1  |   a/a2  | a/a3 |
| ---------: | :-----: | :-----: | :--: |
|       base | skipped | skipped | run  |
| virtual/v1 | skipped | skipped | run  |
| virtual/v2 |   run   |   run   | n/a  |
| virtual/v3 |   run   | skipped | run  |

In a similar manner, a virtual test suite can also have an optional
`skip_base_tests` field to specify all (with `"ALL"`) or a subset of `bases`
tests that will be run under this virtual while the base tests will be skipped.
This will not affect other virtual suites.

```json
{
  "prefix": "v1",
  "bases": ["a/a1"],
}
{
  "prefix": "v2",
  "bases": ["a/a1"],
  "skip_base_tests": "ALL",
}
```
Suppose there are directories `a/a1` and `a/a2` we will run the following tests:

|      Suite |   a/a1  |   a/a2  |
| ---------: | :-----: | :-----: |
|       base | skipped |   run   |
| virtual/v1 |   run   |   n/a   |
| virtual/v2 |   run   |   n/a   |


### Choosing between flag-specific and virtual test suite

For flags whose implementation is still in progress, flag-specific expectations
and virtual test suites represent two alternative strategies for testing both
the enabled code path and non-enabled code path. They are preferred to only
setting a [runtime enabled feature](../../third_party/blink/renderer/platform/RuntimeEnabledFeatures.md)
to `status: "test"` if the feature has substantially different code path from
production because the latter would cause loss of test coverage of the production
code path.

Consider the following when choosing between virtual test suites and
flag-specific suites:

* The
  [waterfall builders](https://dev.chromium.org/developers/testing/chromium-build-infrastructure/tour-of-the-chromium-buildbot)
  and [try bots](https://dev.chromium.org/developers/testing/try-server-usage)
  will run all virtual test suites in addition to the non-virtual tests.
  Conversely, a flag-specific configuration won''t automatically cause the bots
  to test your flag - if you want bot coverage without virtual test suites, you
  will need to follow [these instructions](#running-a-new-flag_specific-suite-in-cq_ci).

* Due to the above, virtual test suites incur a performance penalty for the
  commit queue and the continuous build infrastructure. This is exacerbated by
  the need to restart `content_shell` whenever flags change, which limits
  parallelism. Therefore, you should avoid adding large numbers of virtual test
  suites. They are well suited to running a subset of tests that are directly
  related to the feature, but they don''t scale to flags that make deep
  architectural changes that potentially impact all of the tests.

* Note that using wildcards in virtual test path names (e.g.
  `virtual/blocking_repaint/fast/repaint/*`) is not supported in
  `run_web_tests.py` command line , but you can still use
  `virtual/blocking_repaint` to run all real and virtual tests
  in the suite or `virtual/blocking_repaint/fast/repaint/dir` to run real
  or virtual tests in the suite under a specific directory.

*** note
We can run a virtual test with additional flags. Both the virtual args and the
additional flags will be applied. The fallback order of baselines and
expectations will be: 7) flag-specific virtual, 2) non-flag-specific virtual,
3) flag-specific base, 4) non-flag-specific base
***

### Running a New Flag-Specific Suite in CQ/CI

Assuming you have already created a `FlagSpecificConfig` entry:

1. File a resource request ([internal
   docs](https://g3doc.corp.google.com/company/teams/chrome/ops/business/resources/resource-request-program.md?cl=head&polyglot=chrome-browser#i-need-new-resources))
   for increased capacity in the `chromium.tests` swarming pool and wait for
   approval.
1. Define a new dedicated
   [Buildbot test suite](https://source.chromium.org/chromium/chromium/src/+/main:testing/buildbot/test_suites.pyl;l=1516-1583;drc=0694b605fb77c975a065a3734bdcf3bd81fd8ca4;bpv=0;bpt=0)
   with `--flag-specific` and possibly other special configurations (e.g., fewer shards).
1. Add the Buildbot suite to the relevant `*-blink-rel` builder''s
   composition suite first
   ([example](https://source.chromium.org/chromium/chromium/src/+/main:testing/buildbot/test_suites.pyl;l=5779-5780;drc=0694b605fb77c975a065a3734bdcf3bd81fd8ca4;bpv=0;bpt=0)).
1. Add the flag-specific step name to the relevant builder in
   [`builders.json`](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/tools/blinkpy/common/config/builders.json;l=127-129;drc=ff938aaff9566b2cc442476a51835e0b90b1c6f6;bpv=0;bpt=0).
   `rebaseline-cl` and the WPT importer will now create baselines for that suite.
1. Rebaseline the new suite and add any necessary suppressions under
   `FlagExpectations/`.
1. Enable the flag-specific suite for CQ/CI by adding the Buildbot suite to the
   desired builder.
   This could be an existing CQ builder like
   [`linux-rel`](https://source.chromium.org/chromium/chromium/src/+/main:testing/buildbot/test_suites.pyl;l=5828-5829;drc=0694b605fb77c975a065a3734bdcf3bd81fd8ca4;bpv=0;bpt=0)
   or a dedicated builder like
   [`linux-blink-web-tests-force-accessibility-rel`](https://source.chromium.org/chromium/chromium/src/+/main:infra/config/subprojects/chromium/try/tryserver.chromium.accessibility.star;drc=adad4c6d55e69783ba1f16d30f4bc7367e2e626a;bpv=0;bpt=0), which has customized location filters.

## Tracking Test Failures

All bugs, associated with web test failures must have the
[Test-Layout](https://crbug.com/?q=label:Test-Layout) label. Depending on how
much you know about the bug, assign the status accordingly:

* **Unconfirmed** -- You aren''t sure if this is a simple rebaseline, possible
  duplicate of an existing bug, or a real failure
* **Untriaged** -- Confirmed but unsure of priority or root cause.
* **Available** -- You know the root cause of the issue.
* **Assigned** or **Started** -- You will fix this issue.

When creating a new web test bug, please set the following properties:

* Components: a sub-component of Blink
* OS: **All** (or whichever OS the failure is on)
* Priority: 2 (1 if it''s a crash)
* Type: **Bug**
* Labels: **Test-Layout**

You can also use the _Layout Test Failure_ template, which pre-sets these
labels for you.

## Debugging Web Tests

After the web tests run, you should get a summary of tests that pass or
fail. If something fails unexpectedly (a new regression), you will get a
`content_shell` window with a summary of the unexpected failures. Or you might
have a failing test in mind to investigate. In any case, here are some steps and
tips for finding the problem.

* Take a look at the result. Sometimes tests just need to be rebaselined (see
  below) to account for changes introduced in your patch.
    * Load the test into a trunk Chrome or content_shell build and look at its
      result. (For tests in the http/ directory, start the http server first.
      See above. Navigate to `http://localhost:8000/` and proceed from there.)
      The best tests describe what they''re looking for, but not all do, and
      sometimes things they''re not explicitly testing are still broken. Compare
      it to Safari, Firefox, and IE if necessary to see if it''s correct. If
      you''re still not sure, find the person who knows the most about it and
      ask.
    * Some tests only work properly in content_shell, not Chrome, because they
      rely on extra APIs exposed there.
    * Some tests only work properly when they''re run in the web-test
      framework, not when they''re loaded into content_shell directly. The test
      should mention that in its visible text, but not all do. So try that too.
      See "Running the tests", above.
* If you think the test is correct, confirm your suspicion by looking at the
  diffs between the expected result and the actual one.
    * Make sure that the diffs reported aren''t important. Small differences in
      spacing or box sizes are often unimportant, especially around fonts and
      form controls. Differences in wording of JS error messages are also
      usually acceptable.
    * `third_party/blink/tools/run_web_tests.py path/to/your/test.html` produces
      a page listing all test results. Those which fail their expectations will
      include links to the expected result, actual result, and diff. These
      results are saved to `$root_build_dir/layout-test-results`.
        * Alternatively the `--results-directory=path/for/output/` option allows
          you to specify an alternative directory for the output to be saved to.
    * If you''re still sure it''s correct, rebaseline the test (see below).
      Otherwise...
* If you''re lucky, your test is one that runs properly when you navigate to it
  in content_shell normally. In that case, build the Debug content_shell
  project, fire it up in your favorite debugger, and load the test file either
  from a `file:` URL.
    * You''ll probably be starting and stopping the content_shell a lot. In VS,
      to save navigating to the test every time, you can set the URL to your
      test (`file:` or `http:`) as the command argument in the Debugging section of
      the content_shell project Properties.
    * If your test contains a JS call, DOM manipulation, or other distinctive
      piece of code that you think is failing, search for that in the Chrome
      solution. That''s a good place to put a starting breakpoint to start
      tracking down the issue.
    * Otherwise, you''re running in a standard message loop just like in Chrome.
      If you have no other information, set a breakpoint on page load.
* If your test only works in full web-test mode, or if you find it simpler to
  debug without all the overhead of an interactive session, start the
  content_shell with the command-line flag `--run-web-tests`, followed by the
  URL (`file:` or `http:`) to your test. More information about running web tests
  in content_shell can be found [here](./web_tests_in_content_shell.md).
    * In VS, you can do this in the Debugging section of the content_shell
      project Properties.
    * Now you''re running with exactly the same API, theme, and other setup that
      the web tests use.
    * Again, if your test contains a JS call, DOM manipulation, or other
      distinctive piece of code that you think is failing, search for that in
      the Chrome solution. That''s a good place to put a starting breakpoint to
      start tracking down the issue.
    * If you can''t find any better place to set a breakpoint, start at the
      `TestShell::RunFileTest()` call in `content_shell_main.cc`, or at
      `shell->LoadURL() within RunFileTest()` in `content_shell_win.cc`.
* Debug as usual. Once you''ve gotten this far, the failing web test is just a
  (hopefully) reduced test case that exposes a problem.

### Debugging HTTP Tests

Note: HTTP Tests mean tests under `web_tests/http/tests/`,
which is a subset of WebKit Layout Tests originated suite.
If you want to debug WPT''s HTTP behavior, you should read
["Web platform tests"](./web_platform_tests.md) instead.


To run the server manually to reproduce/debug a failure:

```bash
third_party/blink/tools/run_blink_httpd.py
```

The web tests are served from `http://127.0.0.1:8000/`. For example, to
run the test
`web_tests/http/tests/serviceworker/chromium/service-worker-allowed.html`,
navigate to
`http://127.0.0.1:8000/serviceworker/chromium/service-worker-allowed.html`. Some
tests behave differently if you go to `127.0.0.1` vs. `localhost`, so use
`127.0.0.1`.

To kill the server, hit any key on the terminal where `run_blink_httpd.py` is
running, use `taskkill` or the Task Manager on Windows, or `killall` or
Activity Monitor on macOS.

The test server sets up an alias to the `web_tests/resources` directory. For
example, in HTTP tests, you can access the testing framework using
`src="/js-test-resources/js-test.js"`.

### Tips

Check https://test-results.appspot.com/ to see how a test did in the most recent
~100 builds on each builder (as long as the page is being updated regularly).

A timeout will often also be a text mismatch, since the wrapper script kills the
content_shell before it has a chance to finish. The exception is if the test
finishes loading properly, but somehow hangs before it outputs the bit of text
that tells the wrapper it''s done.

Why might a test fail (or crash, or timeout) on buildbot, but pass on your local
machine?
* If the test finishes locally but is slow, more than 10 seconds or so, that
  would be why it''s called a timeout on the bot.
* Otherwise, try running it as part of a set of tests; it''s possible that a test
  one or two (or ten) before this one is corrupting something that makes this
  one fail.
* If it consistently works locally, make sure your environment looks like the
  one on the bot (look at the top of the stdio for the webkit_tests step to see
  all the environment variables and so on).
* If none of that helps, and you have access to the bot itself, you may have to
  log in there and see if you can reproduce the problem manually.

### Debugging DevTools Tests

* Do one of the following:
    * Option A) Run from the `chromium/src` folder:
      `third_party/blink/tools/run_web_tests.py --additional-driver-flag=''--remote-debugging-port=9222'' --additional-driver-flag=''--remote-allow-origins=*'' --additional-driver-flag=''--debug-devtools'' --timeout-ms=6000000`
    * Option B) If you need to debug an http/tests/inspector test, start httpd
      as described above. Then, run content_shell:
      `out/Default/content_shell --remote-debugging-port=9222 --additional-driver-flag=''--remote-allow-origins=*'' --additional-driver-flag=''--debug-devtools'' --run-web-tests http://127.0.0.1:8000/path/to/test.html`
* Open `http://localhost:9222` in a stable/beta/canary Chrome, click the single
  link to open the devtools with the test loaded.
* In the loaded devtools, set any required breakpoints and execute `test()` in
  the console to actually start the test.

NOTE: If the test is an html file, this means it''s a legacy test so you need to add:
* Add `window.debugTest = true;` to your test code as follows:

  ```javascript
  window.debugTest = true;
  function test() {
    /* TEST CODE */
  }
  ```

### Reproducing flaky inspector protocol tests

https://crrev.com/c/5318502 implemented logging for inspector-protocol tests.
With this CL for each test in stderr you should see Chrome DevTools Protocol
messages that the test and the browser exchanged.

You can use this log to reproduce the failure or timeout locally.

* Prepare a log file and ensure each line contains one protocol message
in the JSON format. Strip any prefixes or non-protocol messages from the
original log.
* Make sure your local test file version matches the version that produced
the log file.
* Run the test using the log file:

  ```sh
  third_party/blink/tools/run_web_tests.py -t Release \
   --additional-driver-flag="--inspector-protocol-log=/path/to/log.txt" \
   http/tests/inspector-protocol/network/url-fragment.js
  ```

## Bisecting Regressions

You can use [`git bisect`](https://git-scm.com/docs/git-bisect) to find which
commit broke (or fixed!) a web test in a fully automated way.  Unlike
[bisect-builds.py](http://dev.chromium.org/developers/bisect-builds-py), which
downloads pre-built Chromium binaries, `git bisect` operates on your local
checkout, so it can run tests with `content_shell`.

Bisecting can take several hours, but since it is fully automated you can leave
it running overnight and view the results the next day.

To set up an automated bisect of a web test regression, create a script like
this:

```bash
#!/bin/bash

# Exit code 125 tells git bisect to skip the revision.
gclient sync || exit 125
autoninja -C out/Debug -j100 blink_tests || exit 125

third_party/blink/tools/run_web_tests.py -t Debug \
  --no-show-results --no-retry-failures \
  path/to/web/test.html
```

Modify the `out` directory, ninja args, and test name as appropriate, and save
the script in `~/checkrev.sh`.  Then run:

```bash
chmod u+x ~/checkrev.sh  # mark script as executable
git bisect start <badrev> <goodrev>
git bisect run ~/checkrev.sh
git bisect reset  # quit the bisect session
```

## Rebaselining Web Tests

See [How to rebaseline](./web_test_expectations.md#How-to-rebaseline).

## Known Issues

See
[bugs with the component Blink>Infra](https://bugs.chromium.org/p/chromium/issues/list?can=2&q=component%3ABlink%3EInfra)
for issues related to Blink tools, include the web test runner.

* If QuickTime is not installed, the plugin tests
  `fast/dom/object-embed-plugin-scripting.html` and
  `plugins/embed-attributes-setting.html` are expected to fail.
* Fluent scrollbar rendering has some tweaks to geometry and behavior that are
  just for web tests. These are described in the
  [Fluent Scrollbars Visual Spec](https://bit.ly/fluent-scrollbars-visual-spec)
  under "Special rendering - Web tests". We''d like to remove them eventually
  ([crbug.com/382298324](https://crbug.com/382298324)).
', NULL, N'development', N'development/testing/web_tests', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Writing Web Tests', N'# Writing Web Tests

[TOC]

## Overview

Web tests should be used to accomplish one of the following goals:

1. The entire surface of Blink that is exposed to the Web should be covered by
   tests that we contribute to [web-platform-tests](./web_platform_tests.md)
   (WPT). This helps us avoid regressions, and helps us identify Web Platform
   areas where the major browsers don''t have interoperable implementations.
   Furthermore, by contributing to projects such as WPT, we share the burden of
   writing tests with the other browser vendors, and we help all the browsers
   get better. This is very much in line with our goal to move the Web forward.
2. When a Blink feature cannot be tested using the tools provided by WPT, and
   cannot be easily covered by
   [C++ unit tests](https://cs.chromium.org/chromium/src/third_party/blink/renderer/web/tests/?q=webframetest&sq=package:chromium&type=cs),
   the feature must be covered by web tests, to avoid unexpected regressions.
   These tests will use Blink-specific testing APIs that are only available in
   [content_shell](./web_tests_in_content_shell.md).

Note: if you are looking for a guide for the Web Platform Test, you should read
["Web platform tests"](./web_platform_tests.md) (WPT). This document does not
cover WPT specific features/behaviors. **The WPT is recommended today rather than
test types mentioned below!**

*** promo
If you know that Blink web tests are upstreamed to other projects, such as
[test262](https://github.com/tc39/test262), please update this document. Most
importantly, our guidelines should to make it easy for our tests to be
upstreamed. The
[blink-dev mailing list](https://groups.google.com/a/chromium.org/forum/#!forum/blink-dev)
will be happy to help you harmonize our current guidelines with communal test
repositories.
***

### Test Types

There are four broad types of web tests, listed in the order of preference.

* *JavaScript Tests* are the web test implementation of
  [xUnit tests](https://en.wikipedia.org/wiki/XUnit). These tests contain
  assertions written in JavaScript, and pass if the assertions evaluate to
  true.
* *Reference Tests* render a test page and a reference page, and pass if the two
  renderings are identical, according to a pixel-by-pixel comparison. These
  tests are less robust, harder to debug, and significantly slower than
  JavaScript tests, and are only used when JavaScript tests are insufficient,
  such as when testing paint code.
* *Pixel Tests* render a test page and compare the result against a pre-rendered
  baseline image in the repository. Pixel tests are less robust than the
  first two types, because the rendering of a page is influenced by
  many factors such as the host computer''s graphics card and driver, the
  platform''s text rendering system, and various user-configurable operating
  system settings. For this reason, it is common for a pixel test to have a
  different reference image for each platform that Blink is tested on, and
  the reference images are
  [quite cumbersome to manage](./web_test_expectations.md). You
  should only write a pixel test if you cannot use a reference test.
* *Text Tests* output pure text which represents the DOM tree, the DOM inner
  text, internal data structure of Blink like layout tree or graphics layer
  tree, or any custom text that the text wants to output. The test passes if the
  output matches a baseline text file in the repository. Text tests outputting
  internal data structures are used as a last resort to test the internal quirks
  of the implementation, and they should be avoided in favor of one of other
  options.
* *Audio tests* output audio results.

*** aside
A JavaScript test is actually a special kind of text test, but its text
baseline can be often omitted.
***

*** aside
A test can be a reference/pixel test and a text test at the same time.
***

## General Principles

Tests should be written under the assumption that they will be upstreamed
to the WPT project. To this end, tests should follow the
[WPT guidelines](https://web-platform-tests.org/writing-tests/).


There is no style guide that applies to all web tests. However, some projects
have adopted style guides, such as the
[ServiceWorker Tests Style guide](https://www.chromium.org/blink/serviceworker/testing).

Our [document on web tests tips](./web_tests_tips.md) summarizes the most
important WPT guidelines and highlights some JavaScript concepts that are worth
paying attention to when trying to infer style rules from existing tests. If
you''re unopinionated and looking for a style guide to follow, the document also
suggests some defaults.

## JavaScript Tests

Whenever possible, the testing criteria should be expressed in JavaScript. The
alternatives, which will be described in future sections, result in slower and
less reliable tests.

All new JavaScript tests should be written using the
[testharness.js](https://github.com/web-platform-tests/wpt/tree/master/resources)
testing framework. This framework is used by the tests in the
[web-platform-tests](https://github.com/web-platform-tests/wpt) repository,
which is shared with all the other browser vendors, so `testharness.js` tests
are more accessible to browser developers.

See the [API documentation](https://web-platform-tests.org/writing-tests/testharness-api.html)
for a thorough introduction to `testharness.js`.

Web tests should follow the recommendations of the above documentation.
Furthermore, web tests should include relevant
[metadata](https://web-platform-tests.org/writing-tests/css-metadata.html). The
specification URL (in `<link rel="help">`) is almost always relevant, and is
incredibly helpful to a developer who needs to understand the test quickly.

Below is a skeleton for a JavaScript test embedded in an HTML page. Note that,
in order to follow the minimality guideline, the test omits the tags `<html>`,
`<head>`, and `<body>`, as they can be inferred by the HTML parser.

```html
<!doctype html>
<title>JavaScript: the true literal is immutable and equal to itself</title>
<link rel="help" href="https://tc39.github.io/ecma262/#sec-boolean-literals">
<script src="/resources/testharness.js"></script>
<script src="/resources/testharnessreport.js"></script>
<script>
''use strict'';

// Synchronous test example.
test(() => {
  const value = true;
  assert_true(value, ''true literal'');
  assert_equals(value.toString(), ''true'', ''the string representation of true'');
}, ''The literal true in a synchronous test case'');

// Asynchronous test example.
async_test(t => {
  const originallyTrue = true;
  setTimeout(t.step_func_done(() => {
    assert_equals(originallyTrue, true);
  }), 0);
}, ''The literal true in a setTimeout callback'');

// Promise test example.
promise_test(() => {
  return new Promise((resolve, reject) => {
    resolve(true);
  }).then(value => {
    assert_true(value);
  });
}, ''The literal true used to resolve a Promise'');

</script>
```

Some points that are not immediately obvious from the example:

* When calling an `assert_` function that compares two values, the first
  argument is the actual value (produced by the functionality being tested), and
  the second argument is the expected value (known good, golden). The order
  is important, because the testing harness relies on it to generate expressive
  error messages that are relied upon when debugging test failures.
* The assertion description (the string argument to `assert_` methods) conveys
  the way the actual value was obtained.
    * If the expected value doesn''t make it clear, the assertion description
      should explain the desired behavior.
    * Test cases with a single assertion should omit the assertion''s description
      when it is sufficiently clear.
* Each test case describes the circumstance that it tests, without being
  redundant.
    * Do not start test case descriptions with redundant terms like "Testing"
      or "Test for".
    * Test files with a single test case should omit the test case description.
      The file''s `<title>` should be sufficient to describe the scenario being
      tested.
* Asynchronous tests have a few subtleties.
    * The `async_test` wrapper calls its function with a test case argument that
      is used to signal when the test case is done, and to connect assertion
      failures to the correct test.
    * `t.done()` must be called after all the test case''s assertions have
      executed.
    * Test case assertions (actually, any callback code that can throw
      exceptions) must be wrapped in `t.step_func()` calls, so that
      assertion failures and exceptions can be traced back to the correct test
      case.
    * `t.step_func_done()` is a shortcut that combines `t.step_func()` with a
      `t.done()` call.

*** promo
Web tests that load from `file://` origins must currently use relative paths
to point to
[/resources/testharness.js](../../third_party/blink/web_tests/resources/testharness.js)
and
[/resources/testharnessreport.js](../../third_party/blink/web_tests/resources/testharnessreport.js).
This is contrary to the WPT guidelines, which call for absolute paths.
This limitation does not apply to the tests in `web_tests/http`, which rely on
an HTTP server, or to the tests in `web_tests/external/wpt`, which are
imported from the [WPT repository](https://github.com/web-platform-tests/wpt).
***

### WPT Supplemental Testing APIs

Some tests simply cannot be expressed using the Web Platform APIs. For example,
some tests that require a user to perform a gesture, such as a mouse click,
cannot be implemented using Web APIs. The WPT project covers some of these cases
via supplemental testing APIs.

When writing tests that rely on supplemental testing APIs, please consider the
cost and benefits of having the tests
[gracefully degrade to manual tests](./web_tests_with_manual_fallback.md) in
the absence of the testing APIs.

*** promo
In many cases, the user gesture is not actually necessary. For example, many
event handling tests can use
[synthetic events](https://developer.mozilla.org/docs/Web/Guide/Events/Creating_and_triggering_events).
***

### Relying on Blink-Specific Testing APIs

Tests that cannot be expressed using the Web Platform APIs or WPT''s testing APIs
use Blink-specific testing APIs. These APIs are only available in
[content_shell](./web_tests_in_content_shell.md), and should only be used as
a last resort.

A downside of Blink-specific APIs is that they are not as well documented as the
Web Platform features. Learning to use a Blink-specific feature requires finding
other tests that use it, or reading its source code.

For example, the most popular Blink-specific API is `testRunner`, which is
implemented in
[content/web_test/renderer/test_runner.h](../../content/web_test/renderer/test_runner.h)
and
[content/web_test/renderer/test_runner.cc](../../content/web_test/renderer/test_runner.cc).
By skimming the `TestRunnerBindings::Install` method, we learn that the
testRunner API is presented by the `.testRunner` etc. objects. Reading the
`TestRunnerBindings::GetObjectTemplateBuilder` method tells us what properties
are available on the `testRunner` object.

Another popular Blink-specific API ''internals'' defined in
[third_party/blink/renderer/core/testing/internals.idl](../../third_party/blink/renderer/core/testing/internals.idl)
contains more direct access to blink internals.

*** note
If possible, a test using blink-specific testing APIs should be written not to
depend on the APIs, so that it can also work directly in a browser. If the test
does need the APIs to work, it should still check if the API is available before
using the API. Note that though we omit the `window.` prefix when using the
APIs, we should use the qualified name in the `if` statement:
```javascript
  if (window.testRunner)
    testRunner.waitUntilDone();
```
***

*** note
`testRunner` is the most popular testing API because it is also used indirectly
by tests that stick to Web Platform APIs. The `testharnessreport.js` file in
`testharness.js` is specifically designated to hold glue code that connects
`testharness.js` to the testing environment. Our implementation is in
[third_party/blink/web_tests/resources/testharnessreport.js](../../third_party/blink/web_tests/resources/testharnessreport.js),
and uses the `testRunner` API.
***

See the [content/web_test/renderer/](../../content/web_test/renderer/) directory and
[WebKit''s LayoutTests guide](https://trac.webkit.org/wiki/Writing%20Layout%20Tests%20for%20DumpRenderTree)
for other useful APIs. For example, `eventSender`
([content/shell/renderer/web_test/event_sender.h](../../content/web_test/renderer/event_sender.h)
and
[content/shell/renderer/web_test/event_sender.cc](../../content/web_test/renderer/event_sender.cc))
has methods that simulate events input such as keyboard / mouse input and
drag-and-drop.

Here is a UML diagram of how the `testRunner` bindings fit into Chromium.

[![UML of testRunner bindings configuring platform implementation](https://docs.google.com/drawings/u/1/d/1KNRNjlxK0Q3Tp8rKxuuM5mpWf4OJQZmvm9_kpwu_Wwg/export/svg?id=1KNRNjlxK0Q3Tp8rKxuuM5mpWf4OJQZmvm9_kpwu_Wwg&pageid=p)](https://docs.google.com/drawings/d/1KNRNjlxK0Q3Tp8rKxuuM5mpWf4OJQZmvm9_kpwu_Wwg/edit)

### Text Test Baselines

By default, all the test cases in a file that uses `testharness.js` are expected
to pass. However, in some cases, we prefer to add failing test cases to the
repository, so that we can be notified when the failure modes change (e.g., we
want to know if a test starts crashing rather than returning incorrect output).
In these situations, a test file will be accompanied by a baseline, which is an
`-expected.txt` file that contains the test''s expected output.

The baselines are generated automatically when appropriate by
`run_web_tests.py`, which is described [here](./web_tests.md), and by the
[rebaselining tools](./web_test_expectations.md).

Text baselines for `testharness.js` should be avoided, as having a text baseline
associated with a `testharness.js` test usually indicates the presence of a bug.
For this reason, CLs that add text baselines must include a
[crbug.com](https://crbug.com) link for an issue tracking the removal of the
text expectations.

* When creating tests that will be upstreamed to WPT, and Blink''s current
  behavior does not match the specification that is being tested, a text
  baseline is necessary. Remember to create an issue tracking the expectation''s
  removal, and to link the issue in the CL description.
* Web tests that cannot be upstreamed to WPT should use JavaScript to
  document Blink''s current behavior, rather than using JavaScript to document
  desired behavior and a text file to document current behavior.

*** promo
Because of [baseline fallback](./web_test_baseline_fallback.md), it may not be
possible to [represent a platform-specific all-`PASS`
status](https://crbug.com/1324638) by the platform baseline''s absence. In such
rare cases, `blink_tool.py rebaseline-cl` will generate a dummy baseline
indicating to `run_web_tests.py` that all subtests are meant to pass:

```
This is a testharness.js-based test.
All subtests passed and are omitted for brevity.
See https://chromium.googlesource.com/chromium/src/+/HEAD/docs/testing/writing_web_tests.md#Text-Test-Baselines for details.
Harness: the test ran to completion.
```

`blink_tool.py optimize-baselines` will automatically remove these dummy
baselines once all platforms are all-`PASS`.
***

### The js-test.js Legacy Harness

*** promo
For historical reasons, older tests are written using the `js-test` harness.
This harness is **deprecated**, and should not be used for new tests.
***

If you need to understand old tests, the best `js-test` documentation is its
implementation at
[third_party/blink/web_tests/resources/js-test.js](../../third_party/blink/web_tests/resources/js-test.js).

`js-test` tests lean heavily on the Blink-specific `testRunner` testing API.
In a nutshell, the tests call `testRunner.dumpAsText()` to signal that the page
content should be dumped and compared against a text baseline (an
`-expected.txt` file). As a consequence, `js-test` tests are always accompanied
by text baselines. Asynchronous tests also use `testRunner.waitUntilDone()` and
`testRunner.notifyDone()` to tell the testing tools when they are complete.

### Tests that use an HTTP Server

By default, tests are loaded as if via `file:` URLs. Some web platform features
require tests served via HTTP or HTTPS, for example absolute paths (`src=/foo`)
or features restricted to secure protocols.

HTTP tests are those under `web_tests/http/tests` (or virtual variants). Use a
locally running HTTP server (Apache) to run them. Tests are served off of ports
8000 and 8080 for HTTP, and 8443 for HTTPS. If you run the tests using
`run_web_tests.py`, the server will be started automatically. To run the server
manually to reproduce or debug a failure:

```bash
cd src/third_party/blink/tools
./run_blink_httpd.py
```

The web tests will be served from `http://127.0.0.1:8000`. For example, to
run the test `http/tests/serviceworker/chromium/service-worker-allowed.html`,
navigate to
`http://127.0.0.1:8000/serviceworker/chromium/service-worker-allowed.html`. Some
tests will behave differently if you go to 127.0.0.1 instead of localhost, so
use 127.0.0.1.

To kill the server, hit any key on the terminal where `run_blink_httpd.py` is
running, or just use `taskkill` or the Task Manager on Windows, and `killall` or
Activity Monitor on MacOS.

The test server sets up an alias to the `web_tests/resources` directory. In
HTTP tests, you can access the testing framework at e.g.
`src="/resources/testharness.js"`.

TODO: Document [wptserve](http://wptserve.readthedocs.io/) when we are in a
position to use it to run web tests.

## Reference Tests (Reftests)

Reference tests, also known as reftests, perform a pixel-by-pixel comparison
between the rendered image of a test page and the rendered image of a reference
page. Most reference tests pass if the two images match, but there are cases
where it is useful to have a test pass when the two images do _not_ match.

Reference tests are more difficult to debug than JavaScript tests, and tend to
be slower as well. Therefore, they should only be used for functionality that
cannot be covered by JavaScript tests.

New reference tests should follow the
[WPT reftests guidelines](https://web-platform-tests.org/writing-tests/reftests.html).
The most important points are summarized below.

* &#x1F6A7; The test page declares the reference page using a
  `<link rel="match">` or `<link rel="mismatch">`, depending on whether the test
  passes when the test image matches or does not match the reference image.
* The reference page must not use the feature being tested. Otherwise, the test
  is meaningless.
* The reference page should be as simple as possible, and should not depend on
  advanced features. Ideally, the reference page should render as intended even
  on browsers with poor CSS support.
* Reference tests should be self-describing.
* Reference tests do _not_ include `testharness.js`.

&#x1F6A7; Our testing infrastructure was designed for the
[WebKit reftests](https://trac.webkit.org/wiki/Writing%20Reftests) that Blink
has inherited. The consequences are summarized below.

* Each reference page must be in the same directory as its associated test.
  Given a test page named `foo` (e.g. `foo.html` or `foo.svg`),
    * The reference page must be named `foo-expected` (e.g.,
      `foo-expected.html`) if the test passes when the two images match.
    * The reference page must be named `foo-expected-mismatch` (e.g.,
      `foo-expected-mismatch.svg`) if the test passes when the two images do
      _not_ match.
* Multiple references and chained references are not supported.

The following example demonstrates a reference test for
[`<ol>`''s reversed attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/ol).
The example assumes that the test page is named `ol-reversed.html`.

```html
<!doctype html>
<link rel="match" href="ol-reversed-expected.html">

<ol reversed>
  <li>A</li>
  <li>B</li>
  <li>C</li>
</ol>
```

The reference page, which must be named `ol-reversed-expected.html`, is below.

```html
<!doctype html>

<ol>
  <li value="3">A</li>
  <li value="2">B</li>
  <li value="1">C</li>
</ol>
```

*** promo
The method for pointing out a test''s reference page is still in flux, and is
being discussed on
[blink-dev](https://groups.google.com/a/chromium.org/d/topic/blink-dev/XsR6PKRrS1E/discussion).
***

## Pixel Tests

A test creates an image result by default unless some `testRunner` API is
called (e.g. `testRunner.dumpAsText()`, `testRunner.dumpAsLayout()`, see
[text tests](#text-tests)) to suppress the image result. A test is a
**pixel test** if it creates an image result but is not a reference test.
The image result is compared against an image baseline, which is an
`-expected.png` file associated with the test, and the test passes if the
image result is identical to the baseline, according to a pixel-by-pixel
comparison.

Pixel tests should still follow the principles laid out above. Pixel tests pose
unique challenges to the desire to have *self-describing* and *cross-platform*
tests. The
[WPT rendering test guidelines](https://web-platform-tests.org/writing-tests/rendering.html)
contain useful guidance. The most relevant pieces of advice are below.

* Whenever possible, use a green paragraph / page / square to indicate success.
  If that is not possible, make the test self-describing by including a textual
  description of the desired (passing) outcome.
* Only use the red color or the word `FAIL` to highlight errors. This does not
  apply when testing the color red.
* &#x1F6A7; Use the
  [Ahem font](https://www.w3.org/Style/CSS/Test/Fonts/Ahem/README) to reduce the
  variance introduced by the platform''s text rendering system. This does not
  apply when testing text, text flow, font selection, font fallback, font
  features, or other typographic information.

*** promo
The default size of the image result of a pixel test is 800x600px, because test
pages are rendered in an 800x600px viewport by default. Normally pixel tests
that do not specifically cover scrolling should fit in an 800x600px viewport
without creating scrollbars.
***

*** promo
The recommendation of using Ahem in pixel tests is being discussed on
[blink-dev](https://groups.google.com/a/chromium.org/d/topic/blink-dev/XsR6PKRrS1E/discussion).
***

The following snippet includes the Ahem font in a web test.

```html
<style>
body {
  font: 10px Ahem;
}
</style>
<script src="/resources/ahem.js"></script>
```

*** promo
Tests outside `web_tests/http` and `web_tests/external/wpt` currently need
to use a relative path to
[/third_party/blink/web_tests/resources/ahem.js](../../third_party/blink/web_tests/resources/ahem.js)
***

### Tests that need to paint, raster, or draw a frame of intermediate output

A web test does not actually draw frames of output until the test exits.
Tests that need to generate a painted frame can use `runAfterLayoutAndPaint()`
defined in [third_party/blink/web_tests/resources/run-after-layout-and-paint.js](../../third_party/blink/web_tests/resources/run-after-layout-and-paint.js)
which will run the machinery to put up a frame, then call the passed callback.
There is also a library at
[third_party/blink/web_tests/paint/invalidation/resources/text-based-repaint.js](../../third_party/blink/web_tests/paint/invalidation/resources/text-based-repaint.js)
to help with writing paint invalidation and repaint tests.

### Tests for scrolling animations

Some web tests need to ensure animations such as middle-click auto-scroll,
fling, etc. get performed properly. When testing in display compositor pixel
dump mode (now the standard), the standard behavior for tests is to
synchronously composite without rastering (to save time). However, animations
run upon surface activation, which only happens once rasterization is performed.
Therefore, for these tests, an additional setting needs to be set. Near the
beginning of these tests, call `setAnimationRequiresRaster()` defined in
[third_party/blink/web_tests/resources/compositor-controls.js](../../third_party/blink/web_tests/resources/compositor-controls.js)
which will enable full rasterization during the test.

## Text tests

A **text test** outputs text result. The result is compared against a text
baseline which is an `-expected.txt` file associated with the test, and the
test passes if the text result is identical to the baseline. A test isn''t a
text test by default until it calls some `testRunner` API to instruct the
test runner to output text. A text test can be categorized based on what kind of
information that the text result represents.

### Layout tree test

If a test calls `testRunner.dumpAsLayout()` or
`testRunner.dumpAsLayoutWithPixelResults()`, The text result will be a
textual representation of Blink''s
[layout tree](https://developers.google.com/web/fundamentals/performance/critical-rendering-path/render-tree-construction)
(called the render tree on that page) of the main frame of the test page.
With `testRunner.dumpChildFrames()` the text result will also include layout
tree of child frames.

Like pixel tests, the output of layout tree tests may depend on
platform-specific details, so layout tree tests often require per-platform
baselines. Furthermore, since the tests obviously depend on the layout tree
structure, that means that if we change the layout tree you have to rebaseline
each layout tree test to see if the results are still correct and whether the
test is still meaningful. There are actually many cases where the layout tree
output is misstated (i.e., wrong), because people didn''t want to have to update
existing baselines and tests. This is really unfortunate and confusing.

For these reasons, layout tree tests should **only** be used to cover aspects
of the layout code that can only be tested by looking at the layout tree. Any
combination of the other test types is preferable to a layout tree test.
Layout tree tests are
[inherited from WebKit](https://webkit.org/blog/1456/layout-tests-practice/), so
the repository may have some unfortunate examples of layout tree tests.

The following page is an example of a layout tree test.

```html
<!doctype html>
<style>
body { font: 10px Ahem; }
span::after {
  content: "pass";
  color: green;
}
</style>
<script src="/resources/ahem.js"></script>
<script>
  if (window.testRunner)
    testRunner.dumpAsLayout();
</script>
<p><span>Pass if a green PASS appears to the right: </span></p>
```

The test page produces the text result below.

```
layer at (0,0) size 800x600
  LayoutView at (0,0) size 800x600
layer at (0,0) size 800x30
  LayoutBlockFlow {HTML} at (0,0) size 800x30
    LayoutBlockFlow {BODY} at (8,10) size 784x10
      LayoutBlockFlow {P} at (0,0) size 784x10
        LayoutInline {SPAN} at (0,0) size 470x10
          LayoutText {#text} at (0,0) size 430x10
            text run at (0,0) width 430: "Pass if a green PASS appears to the right: "
          LayoutInline {<pseudo:after>} at (0,0) size 40x10 [color=#008000]
            LayoutTextFragment (anonymous) at (430,0) size 40x10
              text run at (430,0) width 40: "pass"
```

Notice that the test result above depends on the size of the `<p>` text. The
test page uses the Ahem font (introduced above), whose main design goal is
consistent cross-platform rendering. Had the test used another font, its text
baseline would have depended on the fonts installed on the testing computer, and
on the platform''s font rendering system. Please follow the pixel tests
guidelines and write reliable layout tree tests!

WebKit''s layout tree is described in
[a series of posts](https://webkit.org/blog/114/webcore-rendering-i-the-basics/)
on WebKit''s blog. Some of the concepts there still apply to Blink''s layout tree.

### Text dump test

If `testRunner.dumpAsText()` or `testRunner.dumpAsTextWithPixelResults()`
is called from a test, the test will dump the text contents of the main frame
of the tested page. With `testRunner.dumpChildFrames()` the text
result will also include text contents of child frames. Actually a JavaScript
test is a special kind of text dump test which can often omit the text baseline.

A test can override the default text dump by calling
`testRunner.setCustomTextOutput(string)`. The string parameter can be any
text that the test wants to output. The [`internals` API](../../third_party/blink/renderer/core/testing/internals.idl]
provides methods to get textual representations of internal data structures that
can be used as the parameter of `testRunner.setCustomTextOutput()`.

### Markup dump test

If a test calls `testRunner.dumpAsMarkup()`, the text result will be the DOM
of the main frame of the test. With `testRunner.dumpChildFrames()` the text
result will also include DOM of child frames.

## Audio tests

If a test calls `testRunner.setAudioData(array_buffer)`, the test will
create an audio result. The result will be compared against an audio baseline
which is an `-expected.wav` file associated with the test, and the test passes
if the audio result is identical to the baseline.

## Tests that are both pixel/reference tests and text tests

If a test calls `testRunner.dumpAsTextWithPixelResults()` or
`testRunner.dumpAsLayoutWithPixelResults()`, the test is both a
pixel/reference test and a text test. It will output both pixel result and text
result.

For a test that is both a pixel/reference test and a text test, both pixel and
text results will be compared to baselines, and the test passes if each result
matches the corresponding baseline.

Many of the [paint invalidation tests](../../third_party/blink/web_tests/paint/invalidation)
are of this type. The pixel results (compared against `-expected.png` or
`-expected.html`) ensure correct rendering, and the text results (compared
against `-expected.txt`) ensure correct compositing and raster invalidation
(without unexpected over and under invalidations).

For a layout tree test, whether you want a pixel test and/or a text test depends
on whether you care about the visual image, the details of how that image was
constructed, or both. It is possible for multiple layout trees to produce
the same pixel output, so it is important to make it clear in the test
which outputs you really care about.

## Directory Structure

The [web_tests directory](../../third_party/blink/web_tests) currently
lacks a strict, formal structure. The following directories have special
meaning:

* The `http/` directory hosts tests that require an HTTP server (see above).
* The `resources/` subdirectory in every directory contains binary files, such
  as media files, and code that is shared by multiple test files.

*** note
Some web tests consist of a minimal HTML page that references a JavaScript
file in `resources/`. Please do not use this pattern for new tests, as it goes
against the minimality principle. JavaScript and CSS files should only live in
`resources/` if they are shared by at least two test files.
***
', NULL, N'development', N'development/testing/writing_web_tests', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Web Tests in Content Shell', N'# Running web tests using the content shell

[TOC]

## Compiling

If you want to run web tests,
[build the target `blink_tests`](web_tests.md); this includes all the other
binaries required to run the tests.

## Running

### Using `run_web_tests.py`

You can run web tests using `run_web_tests.py` (in
`src/third_party/blink/tools`).

```bash
third_party/blink/tools/run_web_tests.py -t <build directory> storage/indexeddb
```
To see a complete list of arguments supported, run with `--help`.

*** promo
Windows users need to use `third_party/blink/tools/run_web_tests.bat` instead.
***

*** promo
You can add `<path>/third_party/blink/tools` into `PATH` so that you can
run it from anywhere without the full path.
***

### Run Web Tests Directly with Content Shell

In some cases (e.g. for debugging), you can run web tests directly with
Content Shell executable, with the `--run-web-tests` flag:

```bash
out/Default/content_shell --run-web-tests <url>|<full_test_source_path>|<relative_test_path>
```

`<relative_test_path>` is relative to the [web_tests](../../third_party/blink/web_tests)
directory, regardless of the current directory.

For example:

```bash
out/Default/content_shell --run-web-tests fast/forms/001.html
```
or

```bash
out/Default/content_shell --run-web-tests \
    /home/user/chrome/src/third_party/blink/web_tests/fast/forms/001.html
```
or

```bash
out/Default/content_shell --run-web-tests ~/test/temp-test.html
```

By default, it dumps the text result only (as the dump of pixels and audio
binary data is not human readable) and quits. This can meet the requirement of
most debugging requirements. If you need to interactively debug the test page
(e.g. using devtools), you''ll need to run Content Shell [as a simple
browser](#As-a-simple-browser).

In rare cases, to run Content Shell in the exact same way as
`run_web_tests.py` runs it, you need to run it in the
[protocol mode](../../content/web_test/browser/test_info_extractor.h).

*** note
On the Mac, use `Content Shell.app`, not `content_shell`.

```bash
out/Default/Content\ Shell.app/Contents/MacOS/Content\ Shell ...
```
On Windows, use `content_shell.exe`.
***

#### Running HTTP Tests in Content Shell

HTTP tests reside under [web_tests/http/tests](../../third_party/blink/web_tests/http/tests).
You need to start a web server first. By default it serves generated files from
out/Release:

```bash
vpython3 third_party/blink/tools/run_blink_httpd.py -t <build directory>
```
Then run the test with a localhost URL:

```bash
out/Default/content_shell --run-web-tests http://localhost:8000/<test>
```

It may be necessary specify [--enable-blink-features](https://source.chromium.org/search?q=%22--enable-blink-features%3D%22) explicitly for some tests.

#### Running WPT Tests in Content Shell

Similar to HTTP tests, many WPT (a.k.a. web-platform-tests under
[web_tests/external/wpt](../../third_party/blink/web_tests/external/wpt) directory)
tests require some setup before running in Content Shell:

```bash
vpython3 third_party/blink/tools/run_blink_wptserve.py -t <build directory>
```

Then run the test:

```bash
out/Default/content_shell --run-web-tests http://localhost:8001/<test>
```

If the test requires HTTPS (e.g. the file name contains ".https."), use the
following command instead:

```bash
out/Default/content_shell --run-web-tests https://localhost:8444/<test>
```

### As a simple browser

You can run the shell directly as a simple browser:

```bash
out/Default/content_shell
```

This allows you see how your changes look in Chromium. You can inspect the page
by right clicking and selecting ''Inspect Element''.

You can also use `--remote-debugging-port`

```bash
out/Default/content_shell --remote-debugging-port=9222
```
and open `http://localhost:9222` from another browser to inspect the page.
This is useful when you don''t want DevTools to run in the same Content Shell,
e.g. when you are logging a lot and don''t want the log from DevTools
or when DevTools is unstable in the current revision due to some bugs.

#### Debug WPT

If you want to debug WPT with devtools in Content Shell, you will first need to
start the server:

```bash
vpython3 third_party/blink/tools/run_blink_wptserve.py
```

Then start Content Shell with some additional flags:

```bash
out/Default/content_shell --enable-experimental-web-platform-features --ignore-certificate-errors --host-resolver-rules="MAP nonexistent.*.test ^NOTFOUND, MAP *.test. 127.0.0.1, MAP *.test 127.0.0.1"
```

You are also able to debug the inside of Chromium with a debugger for
particular WPT tests. After starting the WPT server, run particular tests via
Content Shell from the debugger with the following command.
(Refer to your debugger''s manual for how to start a program from your debugger.)

```bash
out/Default/content_shell --run-web-tests http://localhost:8001/<test>
```

Chromium adopts multi-process architecture. If you want to debug the child
renderer processes, use `--single-process` Content Shell option, or
`--renderer-startup-dialog` option and attach the debugger to the renderer
processes after starting the tests. Refer to the Debugging section below for details.

## Debugging

### `--single-process`

The command line switch `--single-process` is useful for starting
content_shell in gdb. In most cases, `--single-process` is good for debugging
except when you want to debug the multiple process behavior or when we have
some bug breaking `--single-process` in particular cases.

### Web tests

See [Run Web Tests Directly with Content Shell](#Run-Web-Tests-Directly-with-Content-Shell).
In most cases you don''t need `--single-process` because `content_shell` is
in single process mode when running most web tests.

See [DevTools frontend](../../third_party/devtools-frontend/src/README.md#basics)
for the commands that are useful for debugging devtools web tests.

### In The Default Multiple Process Mode

In rare cases, you need to debug Content Shell in multiple process mode.
You can ask Content Shell to wait for you to attach a debugger once it spawns a
renderer process by adding the `--renderer-startup-dialog` flag:

```bash
out/Default/content_shell --renderer-startup-dialog --no-sandbox
```

Debugging workers and other subprocesses is simpler with
`--wait-for-debugger-children`, which can have one of two values: `plugin` or
`renderer`.

## Future Work

### Reusing existing testing objects

To avoid writing (and maintaining!) yet another test controller, it is desirable
to reuse an existing test controller. A possible solution would be to change
DRT''s test controller to not depend on DRT''s implementation of the Blink
objects, but rather on the Blink interfaces. In addition, we would need to
extract an interface from the test shell object that can be implemented by
content shell. This would allow for directly using DRT''s test controller in
content shell.
', NULL, N'development', N'development/testing/web_tests_in_content_shell', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Web Tests on Linux', N'# Running web tests on Linux

1.  Build `blink_tests` (see [Linux-specific build instructions](https://chromium.googlesource.com/chromium/src/+/main/docs/linux/build_instructions.md))
1.  Checkout the web tests
    *   If you have an entry in your `.gclient` file that includes
        "web_tests", you may need to comment it out and sync.
    *   You can run a subset of the tests by passing in a path relative to
        `src/third_party/blink/web_tests/`.  For example,
        `third_party/blink/tools/run_web_tests.py fast` will only run the tests under
        `src/third_party/blink/web_tests/fast/`.
1.  When the tests finish, any unexpected results should be displayed.

See [Web Tests](testing/web_tests.md)
for full documentation about set up and available options.

## Pixel Tests

The pixel test results were generated on Ubuntu 10.4 (Lucid). If you''re running
a newer version of Ubuntu, you will get some pixel test failures due to changes
in freetype or fonts.  In this case, you can create a Lucid 64 chroot using
`build/install-chroot.sh` to compile and run tests.

## Fonts

1.  Make sure you have all the dependencies installed by running

```shell
build/install-build-deps.sh
```

2.  Double check that

```shell
ls third_party/test_fonts/test_fonts/
```

is not empty and lists the fonts downloaded through the `test_fonts`
hook in the top level `DEPS` file.

## Plugins

If `fast/dom/object-plugin-hides-properties.html` and
`plugins/embed-attributes-style.html` are failing, try uninstalling
`totem-mozilla` from your system:

    sudo apt-get remove totem-mozilla

## Configuration tips

*   Use an optimized `content_shell` when rebaselining or running a lot of
    tests. ([bug 8475](https://crbug.com/8475) is about how the debug output
    differs from the optimized output.)

    `ninja -C out/Release content_shell`

*   Make sure you have wdiff installed: `sudo apt-get install wdiff` to get
    prettier diff output.
*   Some pixel tests may fail due to processor-specific rounding errors. Build
    using a chroot jail with Lucid 64-bit user space to be sure that your system
    matches the checked in baselines.  You can use `build/install-chroot.sh` to
    set up a Lucid 64 chroot. Learn more about
    [using a linux chroot](linux/using_a_chroot.md).

## Getting a web test into a debugger

There are two ways:

1.  Run `content_shell` directly rather than using `run_web_tests.py`. You
    will need to pass some options:
    *   `--no-timeout` to give you plenty of time to debug
    *   the fully qualified path of the web test (rather than relative to
        `blink/web_tests`).
1.  Or, run as normal but with the
    `--additional-drt-flag=--renderer-startup-dialog
    --additional-drt-flag=--no-timeout --timeout-ms=86400000` flags. The first
    one makes content\_shell bring up a dialog before running, which then would
    let you attach to the process via `gdb -p PID_OF_DUMPRENDERTREE`. The others
    help avoid the test shell and DumpRenderTree timeouts during the debug
    session.

## Using an embedded X server

If you try to use your computer while the tests are running, you may get annoyed
as windows are opened and closed automatically.  To get around this, you can
create a separate X server for running the tests.

1.  Install Xephyr (`sudo apt-get install xserver-xephyr`)
1.  Start Xephyr as display 4: `Xephyr :4 -screen 1024x768x24`
1.  Run the web tests in the Xephyr: `DISPLAY=:4 run_web_tests.py`

Xephyr supports debugging repainting. See the
[Xephyr README](http://cgit.freedesktop.org/xorg/xserver/tree/hw/kdrive/ephyr/README)
for details. In brief:

1.  `XEPHYR_PAUSE=$((500*1000)) Xephyr ...etc...  # 500 ms repaint flash`
1.  `kill -USR1 $(pidof Xephyr)`

If you don''t want to see anything at all, you can use Xvfb (should already be
installed).

1.  Start Xvfb as display 4: `Xvfb :4 -screen 0 1024x768x24`
1.  Run the web tests in the Xvfb: `DISPLAY=:4 run_web_tests.py`

## Tiling Window managers

The web tests want to run with the window at a particular size down to the
pixel level.  This means if your window manager resizes the window it''ll cause
test failures.  This is another good reason to use an embedded X server.

### xmonad

In your `.xmonad/xmonad.hs`, change your config to include a manageHook along
these lines:

```
test_shell_manage = className =? "Test_shell" --> doFloat
main = xmonad $
  defaultConfig
    { manageHook = test_shell_manage <+> manageHook defaultConfig
    ...
```
', NULL, N'development', N'development/testing/web_tests_linux', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Web Tests Tips', N'# Web Tests Tips

The recommendations here are intended to help you write new tests that go
through code review with a minimal number of round trips, remain useful as Blink
evolves, and serve as an asset (rather than a liability) for the team.

While reading existing web tests, please keep in mind that they represent
snapshots taken over many years of an ever-evolving collective opinion of what
good Web pages and solid tests should look like. Thus, it should not come as a
surprise that most existing web tests are not consistent with these
recommendations, and are not even consistent with each other.

*** note
This document intentionally uses _should_ a lot more than _must_, as defined in
[RFC 2119](https://www.ietf.org/rfc/rfc2119.txt). Writing web tests is a
careful act of balancing many concerns, and this humble document cannot possibly
capture the context that rests in the head of an experienced Blink engineer.
***

## General Principles

This section contains guidelines adopted from
[web-platform-tests documentation](https://web-platform-tests.org/writing-tests/general-guidelines.html)
and
[WebKit''s Wiki page on Writing good test cases](https://trac.webkit.org/wiki/Writing%20Layout%20Tests%20for%20DumpRenderTree),
with Blink-specific flavoring.

### Concise

Tests should be **concise**, without compromising on the principles below. Every
element and piece of code on the page should be necessary and relevant to what
is being tested. For example, don''t build a fully functional signup form if you
only need a text field or a button.

Content needed to satisfy the principles below is considered necessary. For
example, it is acceptable and desirable to add elements that make the test
self-describing (see below), and to add code that makes the test more reliable
(see below).

Content that makes test failures easier to debug is considered necessary (to
maintaining a good development speed), and is both acceptable and desirable.

*** promo
Conciseness is particularly important for reference tests and pixel tests, as
the test pages are rendered in an 800x600px viewport. Having content outside the
viewport is undesirable because the outside content does not get compared, and
because the resulting scrollbars are platform-specific UI widgets, making the
test results less reliable.
***

### Fast

Tests should be as **fast** as possible, without compromising on the principles
below. Blink has several thousand web tests that are run in parallel, and
avoiding unnecessary delays is crucial to keeping our Commit Queue in good
shape.

Avoid
[window.setTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setTimeout),
as it wastes time on the testing infrastructure. Instead, use specific event
handlers, such as
[window.onload](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onload),
to decide when to advance to the next step in a test.

### Reliable

Tests should be **reliable** and yield consistent results for a given
implementation. Flaky tests slow down your fellow developers'' debugging efforts
and the Commit Queue.

`window.setTimeout` is again a primary offender here. Asides from wasting time
on a fast system, tests that rely on fixed timeouts can fail when on systems
that are slower than expected.

When adding or significantly modifying a web test, use the command below to
assess its flakiness. While not foolproof, this approach gives you some
confidence, and giving up CPU cycles for mental energy is a pretty good trade.

```bash
third_party/blink/tools/run_web_tests.py path/to/test.html --repeat-each=100
```

The
[PSA on writing reliable web tests](https://docs.google.com/document/d/1Yl4SnTLBWmY1O99_BTtQvuoffP8YM9HZx2YPkEsaduQ/edit).
also has good guidelines for writing reliable tests.

### Self-Describing

Tests should be **self-describing**, so that a project member can recognize
whether a test passes or fails without having to read the specification of the
feature being tested.

`testharness.js` makes a test self-describing when used correctly. Other types
of tests, such as reference tests and
[tests with manual fallback](./web_tests_with_manual_fallback.md),
[must be carefully designed](https://web-platform-tests.org/writing-tests/manual.html#requirements-for-a-manual-test)
to be self-describing.

### Minimal

Tests should require a **minimal** amount of cognitive effort to read and
maintain.

Avoid depending on edge case behavior of features that aren''t explicitly covered
by the test. For example, except where testing parsing, tests should contain
valid markup (no parsing errors).

Tests should provide as much relevant information as possible when failing.
`testharness.js` tests should prefer
[rich assert_ functions](https://web-platform-tests.org/writing-tests/testharness-api.html#list-of-assertions)
to combining `assert_true()` with a boolean operator. Using appropriate
`assert_` functions results in better diagnostic output when the assertion
fails.

### Cross-Platform

Tests should be as **cross-platform** as reasonably possible. Avoid assumptions
about device type, screen resolution, etc. Unavoidable assumptions should be
documented.

When possible, tests should only use Web platform features, as specified
in the relevant standards. When the Web platform''s APIs are insufficient,
tests should prefer to use WPT extended testing APIs, such as
`wpt_automation`, over Blink-specific testing APIs.

Test pages should use the HTML5 doctype (`<!doctype html>`) unless they
specifically cover
[quirks mode](https://developer.mozilla.org/docs/Quirks_Mode_and_Standards_Mode)
behavior.

Tests should avoid using features that haven''t been shipped by the
actively-developed major rendering engines (Blink, WebKit, Gecko, Edge). When
unsure, check [caniuse.com](http://caniuse.com/). By necessity, this
recommendation does not apply to the feature targeted by the test.

*** note
It may be tempting have a test for a bleeding-edge feature X depend on feature
Y, which has only shipped in beta / development versions of various browsers.
The reasoning would be that all browsers that implement X will have implemented
Y. Please keep in mind that Chrome has un-shipped features that made it to the
Beta channel in the past.
***

*** aside
[ES2015](http://benmccormick.org/2015/09/14/es5-es6-es2016-es-next-whats-going-on-with-javascript-versioning/)
is shipped by all major browsers under active development (except for modules),
so using ES2015 features is acceptable.

At the time of this writing, ES2016 is not fully shipped in all major browsers.
***

### Self-Contained

Tests must be **self-contained** and not depend on external network resources.

Unless used by multiple test files, CSS and JavaScript should be inlined using
`<style>` and `<script>` tags. Content shared by multiple tests should be
placed in a `resources/` directory near the tests that share it. See below for
using multiple origins in a test.

### File Names

Test **file names** should describe what is being tested.

File names should use `snake-case`, but preserve the case of any embedded API
names. For example, prefer `document-createElement.html` to
`document-create-element.html`.

### Character Encoding

Tests should use the UTF-8 **character encoding**, which should be declared by
`<meta charset=utf-8>`. A `<meta>` tag is not required (but is acceptable) for
tests that only contain ASCII characters. This guideline does not apply when
specifically testing encodings.

The `<meta>` tag must be the first child of the document''s `<head>` element. In
documents that do not have an explicit `<head>`, the `<meta>` tag must follow
the doctype.

## Coding Style

No coding style is enforced for web tests. This section highlights coding
style aspects that are not consistent across our web tests, and suggests some
defaults for unopinionated developers. When writing web tests for a new part
of the codebase, you can minimize review latency by taking a look at existing
tests, and pay particular attention to these issues. Also beware of per-project
style guides, such as the
[ServiceWorker Tests Style guide](https://www.chromium.org/blink/serviceworker/testing).

### Baseline

[Google''s JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html)
and
[Google''s HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.xml)
are a reasonable baseline for coding style defaults, with the caveat that web
tests do not use Google Closure or JSDoc.

### == vs ===

JavaScript''s
[== operator](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Equality_())
performs some
[type conversion](http://www.ecma-international.org/ecma-262/6.0/#sec-abstract-equality-comparison).
on its arguments, which might be surprising to readers whose experience centers
around C++ or Java. The
[=== operator](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/Comparison_Operators#Identity_strict_equality_())
is much more similar to `==` in C++.

Using `===` everywhere is an easy default that saves you, your reviewer, and any
colleague that might have to debug test failures, from having to reason about
[special cases for ==](http://dorey.github.io/JavaScript-Equality-Table/). At
the same time, some developers consider `===` to add unnecessary noise when `==`
would suffice. While `===` should be universally accepted, be flexible if your
reviewer expresses a strong preference for `==`.

### Let and Const vs Var

JavaScript variable declarations introduced by
[var](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/var)
are hoisted to the beginning of their containing function, which may be
surprising to C++ and Java developers. By contrast,
[const](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/const)
and
[let](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Statements/let)
declarations are block-scoped, just like in C++ and Java, and have the added
benefit of expressing mutability intent.

For the reasons above, a reasonable default is to prefer `const` and `let` over
`var`, with the same caveat as above.

### Strict Mode

JavaScript''s
[strict mode](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Strict_mode),
activated by adding `''use strict'';` to the very top of a script, helps catch
some errors, such as mistyping a variable name, forgetting to declare a
variable, or attempting to change a read-only property.

Given that strict mode gives some of the benefits of using a compiler, adding it
to every test is a good default. This does not apply when specifically testing
sloppy mode behavior.

Some developers argue that adding the `''use strict'';` boilerplate can be
difficult to remember, weighs down smaller tests, and in many cases running a
test case is sufficient to discover any mistyped variable names.

### Promises

[Promises](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Promise)
are a mechanism for structuring asynchronous code. When used correctly, Promises
avoid some of the
[issues of callbacks](http://colintoh.com/blog/staying-sane-with-asynchronous-programming-promises-and-generators).
For these reasons, a good default is to prefer promises over other asynchronous
code structures.

When using promises, be aware of the
[execution order subtleties](https://jakearchibald.com/2015/tasks-microtasks-queues-and-schedules/)
associated with them. Here is a quick summary.

* The function passed to `Promise.new` is executed synchronously, so it finishes
  before the Promise is created and returned.
* The functions passed to `then` and `catch` are executed in
  _separate microtasks_, so they will be executed after the code that resolved
  or rejected the promise finishes, but before any other event handler.

### Classes

[Classes](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Classes)
are syntactic sugar for JavaScript''s
[prototypal inheritance](https://developer.mozilla.org/docs/Web/JavaScript/Inheritance_and_the_prototype_chain).
Compared to manipulating prototypes directly, classes offer a syntax that is
more familiar to developers coming from other programming languages.

A good default is to prefer classes over other OOP constructs, as they will make
the code easier to read for many of your fellow Chrome developers. At the same
time, most web tests are simple enough that OOP is not justified.

### Character Encoding

When HTML pages do not explicitly declare a character encoding, browsers
determine the encoding using an
[encoding sniffing algorithm](https://html.spec.whatwg.org/multipage/syntax.html#determining-the-character-encoding)
that will surprise most modern Web developers. Highlights include a default
encoding that depends on the user''s locale, and non-standardized
browser-specific heuristics.

The easiest way to not have to think about any of this is to add
`<meta charset="utf-8">` to all your tests. This is easier to remember if you
use a template for your web tests, rather than writing them from scratch.

## Tests with Manual Feedback

Tests that rely on the testing APIs exposed by WPT or Blink will not work when
loaded in a standard browser environment. When writing such tests, default to
having the tests gracefully degrade to manual tests in the absence of the
testing APIs.

The
[document on web tests with manual feedback](./web_tests_with_manual_fallback.md)
describes the approach in detail and highlights the trade-off between added test
weight and ease of debugging.
', NULL, N'development', N'development/testing/web_tests_tips', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Baseline Fallback', N'# Web Test Baseline Fallback


*** promo
Read [Web Test Expectations and Baselines](web_test_expectations.md) first
if you have not.
***

Baselines can vary by platforms, in which case we need to check in multiple
versions of a baseline. Meanwhile, we would like to avoid storing identical
baselines by allowing a platform to fall back to another. This document first
introduces how platform-specific baselines are structured and how we search for
a baseline (the fallback mechanism), and then goes into the details of baseline
optimization and rebaselining.

[TOC]

## Terminology

* **Root directory**:
    [`//src/third_party/blink/web_tests`](../../third_party/blink/web_tests)
    is the root directory (of all the web tests and baselines). All relative
    paths in this document start from this directory.
* **Test name**: the name of a test is its relative path from the root
    directory (e.g. `html/dom/foo/bar.html`).
* **Baseline name**: replacing the extension of a test name with
    `-expected.{txt,png,wav}` gives the corresponding baseline name.
* **Virtual tests**: tests can have virtual variants. For example,
    `virtual/gpu/html/dom/foo/bar.html` is the virtual variant of
    `html/dom/foo/bar.html` in the `gpu` suite. Only the latter file exists on
    disk, and is called the base of the virtual test. See
    [Web Tests#Testing Runtime Flags](web_tests.md#testing-runtime-flags)
    for more details.
* **Platform directory**: each directory under
    [`platform/`](../../third_party/blink/web_tests/platform) is a platform
    directory that contains baselines (no tests) for that platform. Directory
    names are in the form of `PLATFORM-VERSION` (e.g. `mac-mac10.12`), except
    for the latest version of a platform which is just `PLATFORM` (e.g. `mac`).

## Baseline fallback

Each platform has a pre-configured fallback when a baseline cannot be found in
this platform directory. A general rule is to have older versions of an OS
falling back to newer versions. Besides, Android falls back to Linux, which then
falls back to Windows. Eventually, all platforms fall back to the root directory
(i.e. the generic baselines that live alongside tests). The rules are configured
by `FALLBACK_PATHS` in each Port class in
[`//src/third_party/blink/tools/blinkpy/web_tests/port`](../../third_party/blink/tools/blinkpy/web_tests/port).

All platforms can be organized into a tree based on their fallback relations (we
are not considering virtual test suites yet). See the lower half (the
non-virtual subtree) of this
[graph](https://docs.google.com/drawings/d/13l3IUlSE99RoKjDwEWuY1O77simAhhF6Wi0fZdkSaMA/).
Walking from a platform to the root gives the **search path** of that platform.
We check each directory on the search path in order and see if "directory +
baseline name" points to a file on disk (note that baseline names are relative
paths), and stop at the first one found.

### Virtual test suites

Now we add virtual test suites to the picture, using a test named
`virtual/gpu/html/dom/foo/bar.html` as an example to demonstrate the process.
The baseline search process for a virtual test consists of two passes:

1. Treat the virtual test name as a regular test name and search for the
   corresponding baseline name using the same search path, which means we are in
   fact searching in directories like `platform/*/virtual/gpu/...`, and
   eventually `virtual/gpu/...` (a.k.a. the virtual root).
2. If no baseline can be found so far, we retry with the non-virtual (base) test
   name `html/dom/foo/bar.html` and walk the search path again.

The [graph](https://docs.google.com/drawings/d/13l3IUlSE99RoKjDwEWuY1O77simAhhF6Wi0fZdkSaMA/)
visualizes the full picture. Note that the two passes are in fact the same with
different test names, so the virtual subtree is a mirror of the non-virtual
subtree. The two trees are connected by the virtual root that has different
ancestors (fallbacks) depending on which platform we start from; this is the
result of the two-pass baseline search.

*** promo
__Note:__ there are in fact two more places to be searched before everything
else: additional directories given via command line arguments and flag-specific
baseline directories. They are maintained manually and are not discussed in this
document.
***

## Tooling implementation

This section describes the implications the fallback mechanism has on the
implementation details of tooling, namely `blink_tool.py`. If you are not
hacking `blinkpy`, you can stop here.

### Optimization

We can remove a baseline if it is the same as its fallback. An extreme example
is that if all platforms have the same result, we can just have a single generic
baseline. Here is the algorithm used by
[`blink_tool.py optimize-baselines`](../../third_party/blink/tools/blinkpy/common/checkout/baseline_optimizer.py)
to optimize the duplication away.

Notice from the previous section that the virtual and non-virtual parts are two
identically structured subtrees. Trees are easy to work with: we can simply
traverse the tree from leaves up to the root, and if there are two identical
baselines on two nodes on the path with no other nodes in between or all nodes
in between have no baselines, keep the one closer to the root (delete the
baseline on the node further from the root).

The virtual root is special because it has multiple parents. Yet if we can cut
the edges between the two subtrees (i.e. to make the virtual subtree
self-contained), we can apply the same algorithm to both of them. A subtree is
self-contained when it does not need to fallback to ancestors, which can be
guaranteed by placing a baseline on its root. If the virtual root already has a
baseline, we can simply ignore these edges without doing anything; otherwise, we
need to make sure all children of the virtual root have baselines by copying
the non-virtual fallbacks to the ones that do not (we cannot copy the generic
baseline to the virtual root because virtual platforms may have different
results).

In addition, the optimizer also removes redundant all-PASS testharness.js
results. Such baselines are redundant when there are no other fallbacks later
on the search path (including if the all-PASS baselines are at root), because
`run_web_tests.py` assumes all-PASS testharness.js results when baselines can
not be found for a platform.

### Rebaseline

The fallback mechanism also affects the rebaseline tool (`blink_tool.py
rebaseline{-cl}`). When asked to rebaseline a test on some platforms, the tool
downloads results from corresponding try bots and put them into the respective
platform directories. This is potentially problematic. Because of the fallback
mechanism, the new baselines may affect some other platforms that are not being
rebaselining but fall back to the rebaselined platforms.

The solution is to copy the current baselines from the to-be-rebaselined
platforms to all the platforms that immediately fall back to them (i.e. down one
level in the fallback tree) before downloading new baselines. This is done in a
hidden internal command
[`blink_tool.py copy-existing-baselines`](../../third_party/blink/tools/blinkpy/tool/commands/copy_existing_baselines.py),
which is always executed by `blink_tool.py rebaseline`.

Finally, `blink_tool.py rebaseline{-cl}` also does optimization in the end by
default.
', NULL, N'development', N'development/testing/web_test_baseline_fallback', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Test Expectations', N'# Web Test Expectations and Baselines

The primary function of the web tests is as a regression test suite; this
means that, while we care about whether a page is being rendered correctly, we
care more about whether the page is being rendered the way we expect it to. In
other words, we look more for changes in behavior than we do for correctness.

[TOC]

All web tests have "expected results", or "baselines", which may be one of
several forms. The test may produce one or more of:

* A text file containing JavaScript log messages.
* A text rendering of the Render Tree.
* A screen capture of the rendered page as a PNG file.
* WAV files of the audio output, for WebAudio tests.

For any of these types of tests, baselines are checked into the web_tests
directory. The filename of a baseline is the same as that of the corresponding
test, but the extension is replaced with `-expected.{txt,png,wav}` (depending on
the type of test output). Baselines usually live alongside tests, with the
exception when baselines vary by platforms; read
[Web Test Baseline Fallback](web_test_baseline_fallback.md) for more
details.

Lastly, we also support the concept of "reference tests", which check that two
pages are rendered identically (pixel-by-pixel). As long as the two tests''
output match, the tests pass. For more on reference tests, see
[Writing ref tests](https://trac.webkit.org/wiki/Writing%20Reftests).

## Failing tests

When the output doesn''t match, there are two potential reasons for it:

* The port is performing "correctly", but the output simply won''t match the
  generic version. The usual reason for this is for things like form controls,
  which are rendered differently on each platform.
* The port is performing "incorrectly" (i.e., the test is failing).

In both cases, the convention is to check in a new baseline (aka rebaseline),
even though that file may be codifying errors. This helps us maintain test
coverage for all the other things the test is testing while we resolve the bug.

*** promo
If a test can be rebaselined, it should always be rebaselined instead of adding
lines to TestExpectations.
***

Bugs at [crbug.com](https://crbug.com) should track fixing incorrect behavior,
not lines in
[TestExpectations](../../third_party/blink/web_tests/TestExpectations). If a
test is never supposed to pass (e.g. it''s testing Windows-specific behavior, so
can''t ever pass on Linux/Mac), move it to the
[NeverFixTests](../../third_party/blink/web_tests/NeverFixTests) file. That
gets it out of the way of the rest of the project.

There are some cases where you can''t rebaseline and, unfortunately, we don''t
have a better solution than either:

1. Reverting the patch that caused the failure, or
2. Adding a line to TestExpectations and fixing the bug later.

In this case, **reverting the patch is strongly preferred**.

These are the cases where you can''t rebaseline:

* The test is a reference test.
* The test gives different output in release and debug; in this case, generate a
  baseline with the release build, and mark the debug build as expected to fail.
* The test is flaky, crashes or times out.
* The test is for a feature that hasn''t yet shipped on some platforms yet, but
  will shortly.

## Handling flaky tests

<!-- TODO(crbug.com/40262793): Describe the current flakiness dashboard and
    LUCI test history. -->

Once you decide that a test is truly flaky, you can suppress it using the
TestExpectations file, as [described below](#updating-the-expectations-files).
We do not generally expect Chromium sheriffs to spend time trying to address
flakiness, though.

## How to rebaseline

Since baselines themselves are often platform-specific, updating baselines in
general requires fetching new test results after running the test on multiple
platforms.

### Rebaselining using try jobs

The recommended way to rebaseline for a currently-in-progress CL is to use
results from try jobs, by using the command-tool
`third_party/blink/tools/blink_tool.py rebaseline-cl`:

1. First, upload a CL.
2. Trigger try jobs by running `blink_tool.py rebaseline-cl`. This should
   trigger jobs on
   [tryserver.blink](https://ci.chromium.org/p/chromium/g/tryserver.blink/builders).
3. Wait for all try jobs to finish.
4. Run `blink_tool.py rebaseline-cl` again to fetch new baselines.
5. Commit the new baselines and upload a new patch.

This way, the new baselines can be reviewed along with the changes, which helps
the reviewer verify that the new baselines are correct. It also means that there
is no period of time when the web test results are ignored.

#### Handle bot timeouts

When a change will cause many tests to fail, the try jobs may exit early because
the number of failures exceeds the limit, or the try jobs may timeout because
more time is needed for the retries. Rebaseline based on such results are not
suggested. The solution is to temporarily increase the number of shards in
[`test_suite_exceptions.pyl`](/testing/buildbot/test_suite_exceptions.pyl) in your CL.
Change the values back to its original value before sending the CL to CQ.

#### Options

The tests which `blink_tool.py rebaseline-cl` tries to download new baselines for
depends on its arguments.

* By default, it tries to download all baselines for tests that failed in the
  try jobs.
* If you pass `--only-changed-tests`, then only tests modified in the CL will be
  considered.
* You can also explicitly pass a list of test names, and then just those tests
  will be rebaselined.
* By default, it finds the try jobs by looking at the latest patchset. If you
  have finished try jobs that are associated with an earlier patchset and you
  want to use them instead of scheduling new try jobs, you can add the flag
  `--patchset=n` to specify the patchset. This is very useful when the CL has
  ''trivial'' patchsets that are created e.g. by editing the CL descrpition.

### Rebaseline script in results.html

Web test results.html linked from bot job result page provides an alternative
way to rebaseline tests for a particular platform.

* In the bot job result page, find the web test results.html link and click it.
* Choose "Rebaseline script" from the dropdown list after "Test shown ... in format".
* Click "Copy report" (or manually copy part of the script for the tests you want
  to rebaseline).
* In local console, change directory into `third_party/blink/web_tests/platform/<platform>`.
* Paste.
* Add files into git and commit.

The generated command includes `blink_tool.py optimize-baselines <tests>` which
removes redundant baselines.

### Local manual rebaselining

```bash
third_party/blink/tools/run_web_tests.py --reset-results foo/bar/test.html
```

If there are current expectation files for `web_tests/foo/bar/test.html`,
the above command will overwrite the current baselines at their original
locations with the actual results. The current baseline means the `-expected.*`
file used to compare the actual result when the test is run locally, i.e. the
first file found in the [baseline search path](https://cs.chromium.org/search/?q=port/base.py+baseline_search_path).

If there are no current baselines, the above command will create new baselines
in the platform-independent directory, e.g.
`web_tests/foo/bar/test-expected.{txt,png}`.

When you rebaseline a test, make sure your commit description explains why the
test is being re-baselined.

### Rebaselining flag-specific expectations

See [Testing Runtime Flags](./web_tests.md#Testing-Runtime-Flags) for details
about flag-specific expectations.

The [Rebaseline Tool](#How-to-rebaseline) supports all flag-specific suites that
[run in CQ/CI](/third_party/blink/tools/blinkpy/common/config/builders.json).
You may also rebaseline flag-specific results locally with:

```bash
third_party/blink/tools/run_web_tests.py --flag-specific=config --reset-results foo/bar/test.html
```

New baselines will be created in the flag-specific baselines directory, e.g.
`web_tests/flag-specific/config/foo/bar/test-expected.{txt,png}`

Then you can commit the new baselines and upload the patch for review.

Sometimes it''s difficult for reviewers to review the patch containing only new
files. You can follow the steps below for easier review.

1. Copy existing baselines to the flag-specific baselines directory for the
   tests to be rebaselined:
   ```bash
   third_party/blink/tools/run_web_tests.py --flag-specific=config --copy-baselines foo/bar/test.html
   ```
   Then add the newly created baseline files, commit and upload the patch.
   Note that the above command won''t copy baselines for passing tests.

2. Rebaseline the test locally:
   ```bash
   third_party/blink/tools/run_web_tests.py --flag-specific=config --reset-results foo/bar/test.html
   ```
   Commit the changes and upload the patch.

3. Request review of the CL and tell the reviewer to compare the patch sets that
   were uploaded in step 1 and step 2 to see the differences of the rebaselines.

## Kinds of expectations files

* [TestExpectations](../../third_party/blink/web_tests/TestExpectations): The
  main test failure suppression file. In theory, this should be used for
  temporarily marking tests as flaky.
  See [the `run_wpt_tests.py` doc](run_web_platform_tests.md) for information
  about WPT coverage for Chrome.
* [ASANExpectations](../../third_party/blink/web_tests/ASANExpectations):
  Tests that fail under ASAN.
* [CfTTestExpecations](../../third_party/blink/web_tests/CfTTestExpecations):
  Tests that fail under Chrome for Testing
* [LeakExpectations](../../third_party/blink/web_tests/LeakExpectations):
  Tests that have memory leaks under the leak checker.
* [MobileTestExpectations](../../third_party/blink/web_tests/MobileTestExpectations)
  Tests that fails under Chrome Android and Chrome WebView platform.
* [MSANExpectations](../../third_party/blink/web_tests/MSANExpectations):
  Tests that fail under MSAN.
* [NeverFixTests](../../third_party/blink/web_tests/NeverFixTests): Tests
  that we never intend to fix (e.g. a test for Windows-specific behavior will
  never be fixed on Linux/Mac). Tests that will never pass on any platform
  should just be deleted, though.
* [SlowTests](../../third_party/blink/web_tests/SlowTests): Tests that take
  longer than the usual timeout to run. Slow tests are given 5x the usual
  timeout.
* [StaleTestExpectations](../../third_party/blink/web_tests/StaleTestExpectations):
  Platform-specific lines that have been in TestExpectations for many months.
  They''re moved here to get them out of the way of people doing rebaselines
  since they''re clearly not getting fixed anytime soon.
* [W3CImportExpectations](../../third_party/blink/web_tests/W3CImportExpectations):
  A record of which W3C tests should be imported or skipped.

### Flag-specific expectations files

It is possible to handle tests that only fail when run with a particular flag
being passed to `content_shell`. See
[web_tests/FlagExpectations/README.txt](../../third_party/blink/web_tests/FlagExpectations/README.txt)
for more.

## Updating the expectations files

### Ordering

The file is not ordered. If you put new changes somewhere in the middle of the
file, this will reduce the chance of merge conflicts when landing your patch.

### Syntax

*** promo
Please see [The Chromium Test List Format](http://bit.ly/chromium-test-list-format)
for a more complete and up-to-date description of the syntax.
***

The syntax of the file is roughly one expectation per line. An expectation can
apply to either a directory of tests, or a specific tests. Lines prefixed with
`# ` are treated as comments, and blank lines are allowed as well.

The syntax of a line is roughly:

```
[ bugs ] [ "[" modifiers "]" ] test_name_or_directory [ "[" expectations "]" ]
```

* Tokens are separated by whitespace.
* **The brackets delimiting the modifiers and expectations from the bugs and the
  test_name_or_directory are not optional**; however the modifiers component is optional. In
  other words, if you want to specify modifiers or expectations, you must
  enclose them in brackets.
* If test_name_or_directory is a directory, it should be ended with `/*`, and all
  tests under the directory will have the expectations, unless overridden by
  more specific expectation lines. **The wildcard is intentionally only allowed at the
  end of test_name_or_directory, so that it will be easy to reason about
  which test(s) a test expectation will apply to.**
* Lines are expected to have one or more bug identifiers, and the linter will
  complain about lines missing them. Bug identifiers are of the form
  `crbug.com/12345`, `code.google.com/p/v8/issues/detail?id=12345` or
  `Bug(username)`.
* If no modifiers are specified, the test applies to all of the configurations
  applicable to that file.
* If specified, modifiers can be one of `Fuchsia`, `Mac`, `Mac11`,
  `Mac11-arm64`, `Mac12`, `Mac12-arm64`, `Mac13`, `Mac13-arm64`, `Mac14`,
  `Mac14-arm64`, `Mac15`, `Mac15-arm64`, `Linux`, `Chrome`, `Win`, `Win10.20h2`,
  `Win11`, `iOS17-Simulator`, and, optionally, `Release`, or `Debug`.
  Check the `# tags: ...` comments [at the top of each
  file](/third_party/blink/web_tests/TestExpectations#7) to see which modifiers
  that file supports.
* Some modifiers are meta keywords, e.g. `Win` represents `Win10.20h2` and `Win11`.
  See the `CONFIGURATION_SPECIFIER_MACROS` dictionary in
  [third_party/blink/tools/blinkpy/web_tests/port/base.py](../../third_party/blink/tools/blinkpy/web_tests/port/base.py)
  for the meta keywords and which modifiers they represent.
* Expectations can be one or more of `Crash`, `Failure`, `Pass`, `Slow`, or
  `Skip`, `Timeout`.
  Some results don''t make sense for some files; check the `# results: ...`
  comment at the top of each file to see what results that file supports.
  If multiple expectations are listed, the test is considered "flaky" and any
  of those results will be considered as expected.

For example:

```
crbug.com/12345 [ Win Debug ] fast/html/keygen.html [ Crash ]
```

which indicates that the "fast/html/keygen.html" test file is expected to crash
when run in the Debug configuration on Windows, and the tracking bug for this
crash is bug \#12345 in the [Chromium issue tracker](https://crbug.com). Note
that the test will still be run, so that we can notice if it doesn''t actually
crash.

Assuming you''re running a debug build on Mac 10.9, the following lines are
equivalent (in terms of whether the test is performed and its expected outcome):

```
fast/html/keygen.html [ Skip ]
Bug(darin) [ Mac10.9 Debug ] fast/html/keygen.html [ Skip ]
```

### Semantics

`Slow` causes the test runner to give the test 5x the usual time limit to run.
`Slow` lines go in the
[`SlowTests` file](../../third_party/blink/web_tests/SlowTests).
A given line cannot have both Slow and Timeout.

Also, when parsing the file, we use two rules to figure out if an expectation
line applies to the current run:

1. If the configuration parameters don''t match the configuration of the current
   run, the expectation is ignored.
2. Expectations that match more of a test name are used before expectations that
   match less of a test name.

If a [virtual test] has no explicit expectations (following the rules above),
it inherits its expectations from the base (nonvirtual) test.

[virtual test]: /docs/testing/web_tests.md#Virtual-test-suites

For example, if you had the following lines in your file, and you were running a
debug build on `Mac10.10`:

```
crbug.com/12345 [ Mac10.10 ] fast/html [ Failure ]
crbug.com/12345 [ Mac10.10 ] fast/html/keygen.html [ Pass ]
crbug.com/12345 [ Win11 ] fast/forms/submit.html [ Failure ]
crbug.com/12345 fast/html/section-element.html [ Failure Crash ]
```

You would expect:

* `fast/html/article-element.html` to fail with a text diff (since it is in the
  fast/html directory).
* `fast/html/keygen.html` to pass (since the exact match on the test name).
* `fast/forms/submit.html` to pass (since the configuration parameters don''t
  match).
* `fast/html/section-element.html` to either crash or produce a text (or image
  and text) failure, but not time out or pass.
* `virtual/foo/fast/html/article-element.html` to fail with a text diff. The
  virtual test inherits its expectation from the first line.

Test expectation can also apply to all tests under a directory (specified with a
name ending with `/*`). A more specific expectation can override a less
specific expectation. For example:
```
crbug.com/12345 virtual/composite-after-paint/* [ Skip ]
crbug.com/12345 virtual/composite-after-paint/compositing/backface-visibility/* [ Pass ]
crbug.com/12345 virtual/composite-after-paint/compositing/backface-visibility/test.html [ Failure ]
```

*** promo
Duplicate expectations are not allowed within the file and will generate
warnings.
***

You can verify that any changes you''ve made to an expectations file are correct
by running:

```bash
third_party/blink/tools/lint_test_expectations.py
```

which will cycle through all of the possible combinations of configurations
looking for problems.
', NULL, N'development', N'development/testing/web_test_expectations', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Expectation Files', N'# Expectation Files

A number of test suites in Chromium use expectation files to handle test
failures in order to have more granular control compared to the usual approach
of entirely disabling failing tests. This documentation goes into the general
usage of expecation files, while suite-specific details are handled in other
files.

[TOC]

Currently, the test suites that use expectation files can be broadly categorized
as Blink tests and GPU tests. Blink-specific documentation can be found
[here][blink_expectation_doc], while GPU-specific documentation can be found
[here][gpu_expectation_doc].

[blink_expectation_doc]: https://source.chromium.org/chromium/chromium/src/+/main:docs/testing/web_test_expectations.md
[gpu_expectation_doc]: https://source.chromium.org/chromium/chromium/src/+/main:docs/gpu/gpu_expectation_files.md

## Design

The full design for the format can be found [here][chromium_test_list_format] if
the overview in this documentation is not sufficient.

[chromium_test_list_format]: http://bit.ly/chromium-test-list-format

## Code

The parser implementation used by Chromium can be found [here][typ_parser]. This
handles the parsing of the text files into Python objects usable by Chromium''s
test harnesses.

[typ_parser]: https://source.chromium.org/chromium/chromium/src/+/main:third_party/catapult/third_party/typ/typ/expectations_parser.py

## Syntax

An expectation file can be broadly broken up into two sections: the header and
test expectations.

### Header

The header consists of specially formatted comments that define what tags and
expected results are usable in expectations later in the file. All header
content must be before any expectation content. Failure to do so will result in
the parser raising errors. An example header is:

```
# tags: [ linux ubuntu jammy
#         mac mac10 mac11 mac12 mac13
#         win win7 win10 ]
# tags: [ release debug ]
# results: [ Failure Skip Slow ]
````

Specifically, the header consists of one or more tag sets and exactly one
expected result set.

#### Tag Sets

Each tag set begins with a `# tags:` comment followed by a space-separated list
of tags between `[ ]`. Order does not matter to the parser, and tags are
case-insensitive. Tag sets can span multiple lines as long as each line starts
with `#` and all tags are within the brackets.

Each tag set contains all the tags that can be used in expectations for a
particular aspect of a test configuration. In the example header, the first tag
set contains values for operating systems, while the second tag set contains
values for browser build type. Grouping tags together into different sets
instead of having a monolithic set with all possible tag values is necessary
in order to handle conflicting expectation detection (explained later in
[the conflict section](#Conflicts)).

One important note about tag sets is that unless a test harness is implementing
custom conflict detection logic, all tags within a set should be mutually
exclusive, i.e. only one tag from each tag set should be produced when running a
test. Failure to do so can result in conflict detection false negatives, the
specifics of which are explained in [the conflict section](#Conflicts).

#### Expected Result Set

The expected result set begins with a `# results:` comment followed by a
space-separated list of expected results between `[ ]`. Order does not matter to
the parser, but expected results are case sensitive. Additionally, only values
[known to the parser][typ_known_results] can be used. The expected results can
span multiple lines as long as each line starts with `#` and all values are
within the brackets.

The expected result set contains all the expected results that can be used in
expectations. The specifics of how each expected result affects test behavior
can differ slightly between test suites, but generally do the following:

* Pass - The default expected result for all tests. Let the test run, and expect
  it to run without issue.
* Failure - Let the test run, but treat failures as a pass.
* Crash - Let the test run, but treat test failures due to crashes as a pass.
* Timeout - Let the test run, but treat test failures due to timeouts as a pass.
* Skip - Do not run the test.
* RetryOnFailure - Re-enable automatic retries of a test if a suite has them
  disabled by default.
* Slow - Indicate that the test is expected to take longer than normal, usually
  as a signal to increase timeouts.

[typ_known_results]: https://source.chromium.org/chromium/chromium/src/+/main:third_party/catapult/third_party/typ/typ/expectations_parser.py;l=40

### Expectations

After the header, the rest of the file consists of test expectations which
specify what non-standard test behavior is expected on specific test machine
configurations. An expectation is a single line in the following format:

```
bug_identifier [ tags ] test_name [ expected_results ]
```

As an example, the following would be an expectation specifying that the
`foo.html` test is expected to fail on Windows machines with Debug browsers:

```
crbug.com/1234 [ win debug ] foo.html [ Failure ]
```

The bug identifier and tags are both optional and can be omitted. Not specifying
any tags means that the expectation applies to the test regardless of where it
is run. When omitting tags, the brackets are also omitted. Additionally,
multiple bug identifiers are allowed as long as they are space-separated. The
parser looks for certain prefixes, e.g. `crbug.com/` to determine what is
considered a bug. This allows the parser to properly disambiguate one or more
bug identifiers from the test name in the event that an expectation does not
have any tags.

Multiple expected results are allowed and are space-separated like tags. As an
example, `[ Failure Crash ]` would specify that the test is expected to either
fail or crash.

Additionally, the test name is allowed to have up to one wildcard at the very
end to match any tests that begin with the specified name. As an example, the
following would be an expectation specifying that any test starting with `foo`
is expected to fail on Windows machines with Debug browsers.

```
crbug.com/1234 [ win debug ] foo* [ Failure ]
```

#### Priority

When using wildcards, it is possible for multiple expectations to apply to a
test at runtime. For example, given the following:

```
[ win ] foo* [ Slow ]
[ win ] foo/bar* [ Failure ]
[ win ] foo/bar/specific_test.html [ Skip ]
```

`foo/bar/specific_test.html` running on a Windows machine would have three
applicable expectations. In these cases, the most specific (i.e. the
longest-named) expectation will be used.

The order in which expectations are defined is *not* considered when determining
priority.

## Conflicts

When more than one expectation exists for a test, it is possible that there will
be a conflict where a test run on a particular test machine could have more than
one expectation apply to it. Whether these conflicts are treated as errors and
how conflicts get resolved are both configurable options via annotations found
under [the annotations section](#Annotations).

### Detection

Two expectations for the same test conflict with each other if they do not use
different tags from at least one shared tag set. As an example, look at the
following expectations:

```
# Group 1
[ win ] foo.html [ Failure ]
[ mac ] foo.html [ Skip ]

# Group 2
[ win ] bar.html [ Failure ]
[ debug ] bar.html [ Skip ]

# Group 3
[ linux ] foo.html [ Failure ]
[ linux debug ] foo.html [ Skip ]
```

Group 1 would not result in a conflict since both `win` and `mac` are from the
same tag set and are different values. Thus, the parser would be able to
determine that at most one expectation will apply when running a test.

Group 2 would result in a conflict since there are no tag sets that both
expectations use, and thus there could be a test configuration that causes both
expectations to apply. In this case, a configuration that produces both the
`win` and `debug` tags is possible. This conflict could be resolved by adding
a browser type tag to the first expectation or an operating system tag to the
second expectation.

Group 3 would result in a conflict since there is a tag set that both
expectations use (operating system), but the exact tag is the same. Thus, a
test running on Linux with a Debug browser would have both expectations apply.
This conflict could be resolved by changing the first expectation to use
`[ linux release ]`.

It is important to be aware of the following when it comes to conflicts:

1. The expectation file has no knowledge of which tag combinations are actually
   possible in the real world, only what is theoretically possible given the
   defined tag sets. A real world example of this would be the use of the Metal
   API, which is Mac-specific. While a human would be able to reason that
   `[ metal ]` implies `[ mac metal ]`, the latter is necessary for the
   conflict detection to work properly.
2. If tag sets include non-mutually-exclusive values and the test suite has not
   implemented custom conflict checking logic, there can be false negatives when
   checking for conflicts. For example, if `win` and `win10` were both in the OS
   tag set, `[ win ] foo.html [ Failure ]` and `[ win10 ] foo.html [ Skip ]`
   would not be found to conflict even though they can in the real world due to
   `win10` being a more specific version of `win`.
3. Expectations that use wildcards can result in conflict detection false
   negatives. Conflict detection is only run on expectations with identical test
   names. Thus, while `[ win ] foo* [ Failure ]` and `[ debug ] foo* [ Skip ]`
   would be found to conflict since the test name is `foo*` in both cases,
   `[ win ] f* [ Failure ]` and `[ debug ] foo* [ Skip ]` would not be found to
   conflict.

### Annotations

By default, conflicts result in a parsing error. However, expectation files
support several annotations to affect how conflicts are handled.

`# conflicts_allowed: true` causes conflicts to no longer cause parsing errors.
Instead, conflicts will be handled gracefully depending on the conflict
resolution setting, the default of which is to take the union of expected
results.

`# conflict_resolution: ` specifies how conflicts will be handled when they are
allowed. Supported values are `union` (the default) and `override`. `union`
causes all conflicted expectations to be merged together. For example, the
following:

```
[ win ] foo.html [ Failure ]
[ debug ] foo.html [ Slow ]
```

would be equivalent to `[ win debug ] foo.html [ Failure Slow ]` when running on
a Windows machine with a Debug browser.

`override` uses whatever expectation was parsed last. Using the above example,
A Windows machine with a Debug browser would end up using the
`[ debug ] foo.html [ Slow ]` expectation.
', NULL, N'development', N'development/testing/expectation_files', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Manual Fallback', N'# Web Tests with Manual Fallback

Some Blink features cannot be automatically tested using the Web Platform. Prime
examples are the APIs that require
[user activation](https://html.spec.whatwg.org/multipage/interaction.html#tracking-user-activation)
(also known as _a user gesture_), such as [Fullscreen](https://developer.mozilla.org/en-US/docs/Web/API/Fullscreen_API).
Automated tests for these Blink features must rely on special APIs, which are
only exposed in testing environments, and are therefore not available in a
normal browser session.

A popular pattern used in these tests is to rely on the user to perform some
manual steps in order to run the test case in a normal browser session. These
tests are effectively
[manual tests](https://web-platform-tests.org/writing-tests/manual.html), with
additional JavaScript code that automatically performs the desired manual steps,
when loaded in an environment that exposes the needed testing APIs.

## Motivation

Web tests that degrade to manual tests in the absence of testing APIs have
the following benefits.

* The manual test component can be debugged in a normal browser session, using
  the rich [developer tools](https://developer.chrome.com/devtools). Tests
  without a manual fallback can only be debugged in the test runner.
* The manual tests can run in other browsers, making it easy to check whether
  our behavior matches other browsers.
* The web tests can form the basis for manual tests that are contributed to
  [web-platform-tests](./web_platform_tests.md).

Therefore, the desirability of adding a manual fallback to a test heavily
depends on whether the feature under test is a Web Platform feature or a
Blink-only feature, and on the developer''s working style. The benefits above
should be weighed against the added design effort needed to build a manual test,
and the size and complexity introduced by the manual fallback.

## Development Tips

A natural workflow for writing a web test that gracefully degrades to a
manual test is to first develop the manual test in a browser, and then add code
that feature-checks for testing APIs, and uses them to automate the test''s
manual steps.

Manual tests should minimize the chance of user error. This implies keeping the
manual steps to a minimum, and having simple and clear instructions that
describe all the configuration changes and user gestures that match the effect
of the Blink-specific APIs used by the test.

## Example

Below is an example of a fairly minimal test that uses a Blink-Specific API
(`window.eventSender`), and gracefully degrades to a manual test.

```html
<!doctype html>
<meta charset="utf-8">
<title>DOM: Event.isTrusted for UI events</title>
<link rel="help" href="https://dom.spec.whatwg.org/#dom-event-istrusted">
<link rel="help" href="https://dom.spec.whatwg.org/#constructing-events">
<meta name="assert"
    content="Event.isTrusted is true for events generated by user interaction">
<script src="../../resources/testharness.js"></script>
<script src="../../resources/testharnessreport.js"></script>

<p>Please click on the button below.</p>
<button>Click Me!</button>

<script>
''use strict'';

setup({ explicit_timeout: true });

promise_test(() => {
  const button = document.querySelector(''button'');
  return new Promise((resolve, reject) => {
    const button = document.querySelector(''button'');
    button.addEventListener(''click'', (event) => {
      resolve(event);
    });

    if (window.eventSender) {
      eventSender.mouseMoveTo(button.offsetLeft, button.offsetTop);
      eventSender.mouseDown();
      eventSender.mouseUp();
    }
  }).then((clickEvent) => {
    assert_true(clickEvent.isTrusted);
  });

}, ''Click generated by user interaction'');

</script>
```

The test exhibits the following desirable features:

* It has a second specification URL (`<link rel="help">`), because the paragraph
  that documents the tested feature (referenced by the primary URL) is not very
  informative on its own.
* It links to the
  [WHATWG Living Standard](https://wiki.whatwg.org/wiki/FAQ#What_does_.22Living_Standard.22_mean.3F),
  rather than to a frozen version of the specification.
* It contains clear instructions for manually triggering the test conditions.
  The test starts with a paragraph (`<p>`) that tells the tester exactly what to
  do, and the `<button>` that needs to be clicked is clearly labeled.
* It disables the timeout mechanism built into `testharness.js` by calling
  `setup({ explicit_timeout: true });`
* It checks for the presence of the Blink-specific testing APIs
  (`window.eventSender`) before invoking them. The test does not automatically
  fail when the APIs are not present.
* It uses [Promises](https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects/Promise)
  to separate the test setup from the assertions. This is particularly helpful
  for manual tests that depend on a sequence of events to occur, as Promises
  offer a composable way to express waiting for asynchronous events that avoids
  [callback hell](http://stackabuse.com/avoiding-callback-hell-in-node-js/).

Notice that the test is pretty heavy compared to a minimal JavaScript test that
does not rely on testing APIs. Only use testing APIs when the desired testing
conditions cannot be set up using Web Platform APIs.
', NULL, N'development', N'development/testing/web_tests_with_manual_fallback', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Addressing Flake', N'# Addressing Flaky Web Tests

This document provides tips and tricks for reproducing and debugging flakes in
[Web Tests](web_tests.md). If you are debugging a flaky Web Platform Test (WPT),
you may wish to check the specific [Addressing Flaky
WPTs](web_platform_tests_addressing_flake.md) documentation.

This document assumes you are familiar with running Web Tests via
`run_web_tests.py`; if you are not then [see
here](web_tests.md#Running-Web-Tests).

[TOC]

## Understanding builder results

Often (e.g. by Flake Portal), you will be pointed to a particular build in which
your test has flaked. You will need the name of the specific build step that has
flaked; usually for Web Tests this is `blink_web_tests` but there are variations
(e.g. `not_site_per_process_blink_web_tests`).

On the builder page, find the appropriate step:

![web_tests_blink_web_tests_step]

While you can examine the individual shard logs to find your test output, it is
easier to view the consolidated information, so scroll down to the **archive
results for blink\_web\_tests** step and click the `web_test_results` link:

![web_tests_archive_blink_web_tests_step]

This will open a new tab with the results viewer. By default your test should be
shown, but if it isn''t then you can click the ''All'' button in the ''Query'' row,
then enter the test filename in the textbox beside ''Filters'':

![web_tests_results_viewer_query_filter]

There are a few ways that a Web Test can flake, and what the result means may
depend on the [test type](writing_web_tests.md#Test-Types):

1. `FAIL` - the test failed. For reference or pixel tests, this means it did not
   match the reference image. For JavaScript tests, the test either failed an
   assertion *or* did not match the [baseline](web_test_expectations.md)
   `-expected.txt` file checked in for it.
   * For image tests, this status is reported as `IMAGE` (as in an image diff).
   * For Javascript tests, this status is reported as `TEXT` (as in a text
     diff).
1. `TIMEOUT` - the test timed out before producing a result. This may happen if
   the test is slow and normally runs close to the timeout limit, but is usually
   caused by waiting on an event that never happens. These unfortunately [do not
   produce any logs](https://crbug.com/487057).
1. `CRASH` - the browser crashed while executing the test. There should be logs
   associated with the crash available.
1. `PASS` - this can happen! Web Tests can be marked as [expected to
   fail](web_test_expectations.md), and if they then pass then that is an
   unexpected result, aka a potential flake.

Clicking on the test row anywhere *except* the test name (which is a link to the
test itself) will expand the entry to show information about the failure result,
including actual/expected results and browser logs if they exist.

In the following example, our flaky test has a `FAIL` result which is a flake
compared to its (default) expected `PASS` result. The test results (`TEXT` - as
explained above this is equivalent to `FAIL`), output, and browser log links are
highlighted.

![web_tests_results_viewer_flaky_test]

## Reproducing Web Test flakes

>TODO: document how to get the args.gn that the bot used

>TODO: document how to get the flags that the bot passed to `run_web_tests.py`

### Repeatedly running tests

Flakes are by definition non-deterministic, so it may be necessary to run the
test or set of tests repeatedly to reproduce the failure. Two flags to
`run_web_tests.py` can help with this:

* `--repeat-each=N` - repeats each test in the test set N times. Given a set of
  tests A, B, and C, `--repeat-each=3` will run AAABBBCCC.
* `--iterations=N` - repeats the entire test set N times. Given a set of tests
  A, B, and C, `--iterations=3` will run ABCABCABC.

## Debugging flaky Web Tests

>TODO: document how to attach gdb

### Seeing logs from content\_shell

When debugging flaky tests, it can be useful to add `LOG` statements to your
code to quickly understand test state. In order to see these logs when using
`run_web_tests.py`, pass the `--driver-logging` flag:

```
./third_party/blink/tools/run_web_tests.py --driver-logging path/to/test.html
```

### Loading the test directly in content\_shell

When debugging a specific test, it can be useful to skip `run_web_tests.py` and
directly run the test under `content_shell` in an interactive session. For many
tests, one can just pass the test path to `content_shell`:

```
out/Default/content_shell third_party/blink/web_tests/path/to/test.html
```

**Caveat**: running tests like this is not equivalent to `run_web_tests.py`,
which passes the `--run-web-tests` flag to `content_shell`. The
`--run-web-tests` flag enables a lot of testing-only code in `content_shell`,
but also runs in a non-interactive mode.

Useful flags to pass to get `content_shell` closer to the `--run-web-tests` mode
include:

* `--enable-blink-test-features` - enables status=test and status=experimental
  features from `runtime_enabled_features.json5`.

>TODO: document how to deal with tests that require a server to be running

[web_tests_blink_web_tests_step]: images/web_tests_blink_web_tests_step.png
[web_tests_archive_blink_web_tests_step]: images/web_tests_archive_blink_web_tests_step.png
[web_tests_results_viewer_query_filter]: images/web_tests_results_viewer_query_filter.png
[web_tests_results_viewer_flaky_test]: images/web_tests_results_viewer_flaky_test.png
', NULL, N'development', N'development/testing/web_tests_addressing_flake', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Android Test Instructions', N'# Android Testing in Chromium

[TOC]

## Test Types

-   **[gtests]**: For writing unit tests in C++. Most tests are cross-platform.
-   **Browser Tests**: Built on top of gtest. Used to write integration tests.
-   **[Robolectric]**: JUnit tests that run on the host machine by emulating (or
    mocking) Android APIs.
-   **[Instrumentation Tests]**: JUnit tests that run on devices / emulators.
    - **Unit Instrumentation Tests**: Unit tests that do not require
      initializing the Content layer. These use [BaseActivityTestRule] often
      using [BlankUiTestActivity].
    - **Integration Instrumentation Tests**: Instrumentation tests that require
      initializing the Content layer to test a certain feature in the end-to-end
      flow. These typically use more specialized test rules such as
      [ContentShellActivityTestRule] or [ChromeActivityTestRule].

[gtests]: android_gtests.md
[Robolectric]: android_robolectric_tests.md
[Instrumentation Tests]: android_instrumentation_tests.md
[BaseActivityTestRule]: https://source.chromium.org/chromium/chromium/src/+/main:base/test/android/javatests/src/org/chromium/base/test/BaseActivityTestRule.java
[BlankUiTestActivity]: https://source.chromium.org/chromium/chromium/src/+/main:ui/android/javatests/src/org/chromium/ui/test/util/BlankUiTestActivity.java
[ContentShellActivityTestRule]: https://source.chromium.org/chromium/chromium/src/+/main:content/shell/android/javatests/src/org/chromium/content_shell_apk/ContentShellActivityTestRule.java
[ChromeActivityTestRule]: https://source.chromium.org/chromium/chromium/src/+/main:chrome/test/android/javatests/src/org/chromium/chrome/test/ChromeActivityTestRule.java

## Device Setup

### Physical Device Setup

#### Root Access

Running tests requires root access, which requires using a userdebug build on
your device.

To use a userdebug build, see
[Running Builds](https://source.android.com/setup/build/running.html). Googlers
can refer to [this page](https://goto.google.com/flashdevice).

If you can''t run "adb root", you will get an error when trying to install
the test APKs like "adb: error: failed to copy" and
"remote secure_mkdirs failed: Operation not permitted" (use "adb unroot" to
return adb to normal).

#### ADB Debugging

The adb executable exists within the Android SDK:

```shell
third_party/android_sdk/public/platform-tools/adb
```

In order to allow the ADB to connect to the device, you must enable USB
debugging:

* Developer options are hidden by default. To unhide them:
    *   Go to "About phone"
    *   Tap 10 times on "Build number"
    *   The "Developer options" menu will now be available.
    *   Check "USB debugging".
    *   Un-check "Verify apps over USB".

#### Screen

You **must** ensure that the screen stays on while testing: `adb shell svc power
stayon usb` Or do this manually on the device: Settings -> Developer options ->
Stay Awake.

If this option is greyed out, stay awake is probably disabled by policy. In that
case, get another device or log in with a normal, unmanaged account (because the
tests will break in exciting ways if stay awake is off).

#### Disable Verify Apps

You may see a dialog like [this
one](http://www.samsungmobileusa.com/simulators/ATT_GalaxyMega/mobile/screens/06-02_12.jpg),
which states, _Google may regularly check installed apps for potentially harmful
behavior._ This can interfere with the test runner. To disable this dialog, run:

```shell
adb shell settings put global package_verifier_enable 0
```

### Using Emulators

Running tests on emulators is the same as [on device](#Running-Tests). Refer to
[android_emulator.md](/docs/android_emulator.md) for setting up emulators.

## Building Tests

If you''re adding a new test file, you''ll need to explicitly add it to a gn
target. If you''re adding a test to an existing file, you won''t need to make gn
changes, but you may be interested in where your test winds up. In either case,
here are some guidelines for where a test belongs:

### C++

C++ test files typically belong in `<top-level directory>_unittests` (e.g.
`base_unittests` for `//base`). There are a few exceptions -- browser tests are
typically their own target (e.g. `content_browsertests` for `//content`, or
`browser_tests` for `//chrome`), and some unit test suites are broken at the
second directory rather than the top-level one.

### Java

Java test files vary a bit more widely than their C++ counterparts:

-   Instrumentation test files -- i.e., tests that will run on a device --
    typically belong in either `<top-level directory>_javatests` or `<top-level
    directory>_test_java`. Regardless, they''ll wind up getting packaged into one
    of a few test APKs:
    -   `webview_instrumentation_test_apk` for anything in `//android_webview`
    -   `content_shell_test_apk` for anything in `//content` or below
    -   `chrome_public_test_apk` for most things in `//chrome`
-   JUnit or Robolectric test files -- i.e., tests that will run on the host --
    typically belong in `<top-level directory>_junit_tests` (e.g.
    `base_junit_tests` for `//base`), though here again there are cases
    (particularly in `//components`) where suites are split at the second
    directory rather than the top-level one.

Once you know what to build, just do it like you normally would build anything
else, e.g.: `ninja -C out/Release chrome_public_test_apk`

### Determining Test Target

If you do not know what target a test file belongs to, you can use
`//tools/autotest.py` to figure it out fo you:

```sh
# Builds relevant test target and then runs the test:
tools/autotest.py -C <output directory> TestClassName
```

## Running Tests

All functional tests should be runnable via the wrapper scripts generated at
build time:

```sh
<output directory>/bin/run_<target_name> [options]
```

Note that tests are sharded across all attached devices unless explicitly told
to do otherwise by `-d/--device`.

The commands used by the buildbots are printed in the logs. Look at
https://build.chromium.org/ to duplicate the same test command as a particular
builder.

### Listing Available Tests

Use `--list-tests` to list what tests are available.

```sh
# Prints out all available tests:
<output directory>/bin/run_<target_name> --list-tests

# Prints out all available tests that match a filter:
<output directory>/bin/run_<target_name> --list-tests -f "*MyFilter*"
```

### INSTALL\_FAILED\_CONTAINER\_ERROR or INSTALL\_FAILED\_INSUFFICIENT\_STORAGE

If you see this error when the test runner is attempting to deploy the test
binaries to the AVD emulator, you may need to resize your userdata partition
with the following commands:

```shell
# Resize userdata partition to be 1G
resize2fs android_emulator_sdk/sdk/system-images/android-25/x86/userdata.img 1G

# Set filesystem parameter to continue on errors; Android doesn''t like some
# things e2fsprogs does.
tune2fs -e continue android_emulator_sdk/sdk/system-images/android-25/x86/userdata.img
```

### AdbCommandFailedError: failed to stat remote object

There''s a known issue (https://crbug.com/1094062) where the unit test binaries can fail on
Android R and later: if you see this error, try rerunning on an Android version
with API level <= 29 (Android <= Q).

## Symbolizing Crashes

Crash stacks are logged and can be viewed using `adb logcat`. To symbolize the
traces, define `CHROMIUM_OUTPUT_DIR=$OUTDIR` where `$OUTDIR` is the argument you
pass to `ninja -C`, and pipe the output through
`third_party/android_platform/development/scripts/stack`. If
`$CHROMIUM_OUTPUT_DIR` is unset, the script will search `out/Debug` and
`out/Release`. For example:

```shell
# If you build with
ninja -C out/Debug chrome_public_test_apk
# You can run:
adb logcat -d | third_party/android_platform/development/scripts/stack

# If you build with
ninja -C out/android chrome_public_test_apk
# You can run:
adb logcat -d | CHROMIUM_OUTPUT_DIR=out/android third_party/android_platform/development/scripts/stack
# or
export CHROMIUM_OUTPUT_DIR=out/android
adb logcat -d | third_party/android_platform/development/scripts/stack
```

## Robolectric Tests

JUnit tests are Java unittests running on the host instead of the target device.
They are faster to run and therefore are recommended over instrumentation tests
when possible.

The JUnits tests are usually following the pattern of *target*\_junit\_tests,
for example, `content_junit_tests` and `chrome_junit_tests`.

When adding a new JUnit test, the associated `BUILD.gn` file must be updated.
For example, adding a test to `chrome_junit_tests` requires to update
`chrome/android/BUILD.gn`.

```shell
# Build the test suite.
ninja -C out/Default chrome_junit_tests

# Run the test suite.
out/Default/bin/run_chrome_junit_tests

# Run a subset of tests. You might need to pass the package name for some tests.
out/Default/bin/run_chrome_junit_tests -f "org.chromium.chrome.browser.media.*"
```

### Debugging

Similar to [debugging apk targets](/docs/android_debugging_instructions.md#debugging-java):

```shell
out/Default/bin/run_chrome_junit_tests --wait-for-java-debugger
out/Default/bin/run_chrome_junit_tests --wait-for-java-debugger  # Specify custom port via --debug-socket=9999
```

## Gtests

```shell
# Build a test suite
ninja -C out/Release content_unittests

# Run a test suite
out/Release/bin/run_content_unittests [-vv]

# Run a subset of tests and enable some "please go faster" options:
out/Release/bin/run_content_unittests --fast-local-dev -f "ByteStreamTest.*"
```

## Instrumentation Tests

In order to run instrumentation tests, you must leave your device screen ON and
UNLOCKED. Otherwise, the test will timeout trying to launch an intent.
Optionally you can disable screen lock under Settings -> Security -> Screen Lock
-> None.

Next, you need to build the app, build your tests, and then run your tests
(which will install the APK under test and the test APK automatically).

Examples:

ContentShell tests:

```shell
# Build the tests:
ninja -C out/Release content_shell_test_apk

# Run the test suite:
out/Release/bin/run_content_shell_test_apk [-vv]

# Run a subset of tests and enable some "please go faster" options:
out/Release/bin/run_content_shell_test_apk --fast-local-dev -f "*TestClass*"
```

Android WebView tests:

See [WebView''s instructions](/android_webview/docs/test-instructions.md).

In order to run a subset of tests, use -f to filter based on test class/method
or -A/-E to filter using annotations.

More Filtering examples:

```shell
# Run a specific test class
out/Debug/bin/run_content_shell_test_apk -f "AddressDetectionTest.*"

# Run a specific test method
out/Debug/bin/run_content_shell_test_apk -f AddressDetectionTest#testAddressLimits

# Run a subset of tests by size (Smoke, SmallTest, MediumTest, LargeTest,
# EnormousTest)
out/Debug/bin/run_content_shell_test_apk -A Smoke

# Run a subset of tests by annotation, such as filtering by Feature
out/Debug/bin/run_content_shell_test_apk -A Feature=Navigation
```

You might want to add stars `*` to each as a regular expression, e.g.
`*`AddressDetectionTest`*`

### Debugging

Similar to [debugging apk targets](/docs/android_debugging_instructions.md#debugging-java):

```shell
out/Debug/bin/run_content_shell_test_apk --wait-for-java-debugger
```

### Deobfuscating Java Stacktraces

If running with `is_debug=false`, Java stacks from logcat need to be fixed up:

```shell
build/android/stacktrace/java_deobfuscate.py out/Release/apks/ChromePublicTest.apk.mapping < stacktrace.txt
```

Any stacks produced by test runner output will already be deobfuscated.


## Running Blink Web Tests

See [Web Tests](web_tests.md).

## Running Telemetry (Perf) Tests

See [Telemetry](https://chromium.googlesource.com/catapult/+/HEAD/telemetry/README.md).

## Running GPU tests

(e.g. the "Android Debug (Nexus 7)" bot on the chromium.gpu waterfall)

See https://www.chromium.org/developers/testing/gpu-testing for details. Use
`--browser=android-content-shell`. Examine the stdio from the test invocation on
the bots to see arguments to pass to `src/content/test/gpu/run_gpu_test.py`.
', NULL, N'development', N'development/testing/android_test_instructions', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Android GTests', N'# How GTests work on Android

gtests are [googletest](https://github.com/google/googletest)-based C++ tests.
On Android, they run on a device. In most cases, they''re packaged as APKs, but
there are a few cases where they''re run as raw executables. The latter is
necessary in a few cases, particularly when manipulating signal handlers, but
isn''t possible when the suite needs to call back through the JNI into Java code.

[TOC]

## APKs

### GN

Gtest APKs are built by default by the
[test](https://codesearch.chromium.org/chromium/src/testing/test.gni?type=cs&q=file:%5Esrc%5C/testing%5C/test.gni$+template%5C("test"%5C)&sq=package:chromium)
template, e.g.

```python
test("sample_gtest") {
  # ...
}
```

This uses gn''s native
[shared_library](https://chromium.googlesource.com/chromium/src/+/main/tools/gn/docs/reference.md#shared_library_Declare-a-shared-library-target)
target type along with the
[unittest_apk](https://codesearch.chromium.org/chromium/src/build/config/android/rules.gni?type=cs&q=file:%5Esrc%5C/build%5C/config%5C/android%5C/rules.gni$+template%5C(%5C"unittest_apk%5C"%5C)&sq=package:chromium)
template to build an APK containing:

 - One or more .so files containing the native code on which the test suite
depends
 - One or more .dex files containing the Java code on which the test suite
depends
 - A [manifest](https://developer.android.com/guide/topics/manifest/manifest-intro.html)
file that contains `<instrumentation>` and `<activity>` elements (among others).

### Harness

GTest APKs are packaged with a harness that consists of:

  - [NativeTestInstrumentationTestRunner], an instrumentation entry point that
handles running one or more sequential instances of a test Activity. Typically,
unit test suites will only use one instance of the Activity and will run all of
the specified tests in it, while browser test suites will use multiple instances
and will only run one test per instance.
  - Three [Activity](https://developer.android.com/reference/android/app/Activity.html)-based
classes
([NativeUnitTestActivity](https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeUnitTestActivity.java),
[NativeUnitTestNativeActivity](https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeUnitTestNativeActivity.java),
and
[NativeBrowserTestActivity](https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeBrowserTestActivity.java))
that primarily act as process entry points for individual test shards.
Only one is used in any given suite.
  - [NativeTest] and [NativeUnitTest],
which handle formatting arguments for googletest and transferring control across
the JNI.
  - [testing::android::RunTests](https://codesearch.chromium.org/chromium/src/testing/android/native_test/native_test_launcher.cc?q=file:%5Esrc%5C/testing%5C/android%5C/native_test%5C/native_test_launcher.cc$+RunTests&sq=package:chromium),
the function on the native side, which initializes the native command-line,
redirects stdout either to a FIFO or a regular file, optionally waits for a
debugger to attach to the process, sets up the test data directories, and then
dispatches to googletest''s `main` function.

### Runtime

 1. The test runner calls `am instrument` with a bunch of arguments,
    includes several extras that are arguments to either
    [NativeTestInstrumentationTestRunner] or [NativeTest]. This results in an
    intent being sent to [NativeTestInstrumentationTestRunner].
 2. [NativeTestInstrumentationTestRunner] is created. In its onCreate, it
    parses its own arguments from the intent and retains all other arguments
    to be passed to the Activities it''ll start later. It also creates a
    temporary file in the external storage directory for stdout. It finally
    starts itself.
 3. [NativeTestInstrumentationTestRunner] is started. In its onStart, it prepares
    to receive notifications about the start and end of the test run from the
    Activities it''s about to start. It then creates [ShardStarter]
    that will start the first test shard and adds that to the current
    [Handler](https://developer.android.com/reference/android/os/Handler.html).
 4. The [ShardStarter] is executed, starting the test Activity.
 5. The Activity starts, possibly doing some process initialization, and hands
    off to the [NativeTest].
 6. The [NativeTest] handles some initialization and informs the
    [NativeTestInstrumentationTestRunner] that it has started. On hearing this,
    the [NativeTestInstrumentationTestRunner] creates a [ShardMonitor] 
    that will monitor the execution of the test Activity.
 7. The [NativeTest] hands off to testing::android::RunTests. The tests run.
 8. The [NativeTest] informs the [NativeTestInstrumentationTestRunner] that is has
    completed. On hearing this, the [ShardMonitor] creates a [ShardEnder].
 9. The [ShardEnder] is executed, killing the child process (if applicable),
    parsing the results from the stdout file, and either launching the next
    shard via [ShardStarter] (in which case the process returns to #4) or sending
    the results out to the test runner and finishing the instrumentation.

## Executables

### GN

Gtest executables are built by passing
`use_raw_android_executable = True` to the 
[test](https://codesearch.chromium.org/chromium/src/testing/test.gni?type=cs&q=file:%5Esrc%5C/testing%5C/test.gni$+template%5C("test"%5C)&sq=package:chromium)
template, e.g.

```python
test("sample_gtest_executable") {
  if (is_android) {
    use_raw_android_executable = true
  }
  # ...
}
```

This uses gn''s native
[executable](https://chromium.googlesource.com/chromium/src/+/main/tools/gn/docs/reference.md#executable_Declare-an-executable-target)
target type, then copies the resulting executable and any requisite shared libraries
to ```${root_out_dir}/${target_name}__dist``` (e.g. ```out/Debug/breakpad_unittests__dist```).

### Harness

Unlike APKs, gtest suites built as executables require no Android-specific harnesses.

### Runtime

The test runner simply executes the binary on the device directly and parses the
stdout on its own.

[NativeTest]: https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeTest.java
[NativeTestInstrumentationTestRunner]: https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeTestInstrumentationTestRunner.java
[NativeUnitTest]: https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeUnitTest.java
[ShardEnder]: https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeTestInstrumentationTestRunner.java?q=file:NativeTestInstrumentationTestRunner.java+class:ShardEnder&sq=package:chromium
[ShardMonitor]: https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeTestInstrumentationTestRunner.java?q=file:NativeTestInstrumentationTestRunner.java+class:ShardMonitor&sq=package:chromium
[ShardStarter]: https://codesearch.chromium.org/chromium/src/testing/android/native_test/java/src/org/chromium/native_test/NativeTestInstrumentationTestRunner.java?q=file:NativeTestInstrumentationTestRunner.java+class:ShardStarter&sq=package:chromium
', NULL, N'development', N'development/testing/android_gtests', 1, GETDATE(), GETDATE(), 7);
INSERT INTO Articles (Title, Content, Summary, Category, Path, IsPublished, CreatedAt, UpdatedAt, AuthorId)
VALUES (N'Android Instrumentation Tests', N'# Android Instrumentation Tests

Instrumentation tests are JUnit 4 tests that run on devices or emulators. They
can be either unit tests or integration test.

[TOC]

## Tracing

Enabling tracing during a test run allows all the function calls involved to be
observed in a visual display (using Chrome''s built-in chrome://tracing feature).
To run a test with tracing, add the `--trace-output` flag to the command used to
call the instrumentation test (either running the test_runner.py script, or a
generated binary such as `run_chrome_public_test_apk`). The `--trace-output` flag
takes a filename, which, after the test run, will contain a JSON file readable
by chrome://tracing.

By default, the trace includes only certain function calls important to the test
run, both within the Python test runner framework and the Java code running on
the device. For a more detailed look, add the (no-argument) `--trace-all` flag.
This causes every function called on the Python side to be added to the trace.

## Test Batching Annotations

The [`@Batch("group_name")`](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/Batch.java)
annotation is used to run all tests with the same batch group name in the same
instrumentation invocation. In other words, the browser process is not
restarted between these tests, and so any changes to global state, like
launching an Activity, will persist between tests within a batch group. The
benefit of this is that these tests run significantly faster - the per-test cost
of restarting the process can be as high as 10 seconds (usually around 2
seconds), and that doesn''t count the cost of starting an Activity like
ChromeTabbedActivity.

## Size Annotations

Size annotations are [used by the test runner] to determine the length of time
to wait before considering a test hung (i.e., its timeout duration).

Annotations from `androidx.test.filters`:

 - [`@SmallTest`](https://developer.android.com/reference/androidx/test/filters/SmallTest.html) (timeout: **10 seconds**)
 - [`@MediumTest`](https://developer.android.com/reference/androidx/test/filters/MediumTest.html) (timeout: **30 seconds**)
 - [`@LargeTest`](https://developer.android.com/reference/androidx/test/filters/LargeTest.html) (timeout: **2 minutes**)

Annotations from `//base`:

 - [`@EnormousTest`](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/EnormousTest.java)
(timeout: **5 minutes**) Typically used for tests that require WiFi.
 - [`@IntegrationTest`](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/IntegrationTest.java)
(timeout: **10 minutes**) Used for tests that run against real services.
 - [`@Manual`](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/Manual.java)
(timeout: **10 hours**) Used for manual tests.

[used by the test runner]: https://source.chromium.org/search?q=file:local_device_instrumentation_test_run.py%20symbol:TIMEOUT_ANNOTATIONS&sq=&ss=chromium

## Annotations that Disable Tests

There are several annotations that control whether or not a test runs.
Some are conditional, others are not.

### Unconditional Disabling

[**@DisabledTest**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/DisabledTest.java)
unconditionally disables a test.
```java
@DisabledTest(
    // Describes why the test is disabled. Typically includes a crbug link.
    message = ""
)
```

### Conditional Disabling

There are two primary annotation categories that conditionally disable tests:
**@DisableIf** and **@Restriction**. The **@DisableIf** annotations are intended
to temporarily disable a test in certain scenarios where it *should* work but
doesn''t. In contrast, the **@Restriction** annotation is intended to
permanently limit a test to specific configurations. It signifies that the test
was not, is not, and will not be intended to run beyond those configurations.
In both cases, conditional disabling manifests as a skipped test.

[**@DisableIf.Build**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/DisableIf.java#25)
allows for conditional test disabling based on values in
[`android.os.Build`](https://developer.android.com/reference/android/os/Build.html):

```java
@DisableIf.Build(

    // Describes why the test is disabled.
    message = "",

    // Disables the test on SDK levels that match the given conditions.
    // Checks against Build.VERSION.SDK_INT.
    sdk_is_greater_than = 0,
    sdk_is_less_than = Integer.MAX_VALUE,

    // Disables the test on devices that support the given ABI
    // (e.g. "arm64-v8a"). Checks against:
    //  - Build.SUPPORTED_ABIS on L+
    //  - Build.CPU_ABI and Build.CPU_ABI2 otherwise
    supported_abis_includes = "",

    // Disables the test on devices with hardware that matches the given
    // value. Checks against Build.HARDWARE.
    hardware_is = "",

    // Disables the test on devices with product names that contain the
    // given value. Checks against Build.PRODUCT.
    product_name_includes = "",

)
```

[**@DisableIf.Device**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/DisableIf.java#40)
allows for conditional test disabling based on whether
a device is a phone, a tablet, or a "large tablet" as determined by
[org.chromium.ui.base.DeviceFormFactor](https://chromium.googlesource.com/chromium/src/+/main/ui/android/java/src/org/chromium/ui/base/DeviceFormFactor.java).
This is available to tests in
[//ui](https://chromium.googlesource.com/chromium/src/+/main/ui/)
or code that uses //ui.

```java
@DisableIf.Device(
    // Disables the test on devices that match the given type(s) as described
    // above.
    type = {}
)
```

[**@Restriction**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/Restriction.java)
currently allows for conditional test disabling based on device
type, device performance, internet connectivity, whether Google Play Services is
up to date, and whether the build was an official one.

```java
@Restriction(
    // Possible values include:
    //
    // base:
    //  - Restriction.RESTRICTION_TYPE_LOW_END_DEVICE
    //    Restricts the test to low-end devices as determined by SysUtils.isLowEndDevice().
    //
    //  - Restriction.RESTRICTION_TYPE_NON_LOW_END_DEVICE
    //    Restricts the test to non-low-end devices as determined by SysUtils.isLowEndDevice().
    //
    //  - Restriction.RESTRICTION_TYPE_INTERNET
    //    Restricts the test to devices that have an internet connection.
    //
    // chrome:
    //  - ChromeRestriction.RESTRICTION_TYPE_GOOGLE_PLAY_SERVICES
    //    Restricts the test to devices with up-to-date versions of Google Play Services.
    //
    //  - ChromeRestriction.RESTRICTION_TYPE_OFFICIAL_BUILD
    //    Restricts the test to official builds as determined by ChromeVersionInfo.isOfficialBuild().
    //
    // ui:
    //  - UiRestriction.RESTRICTION_TYPE_PHONE
    //    Restricts the test to phones as determined by DeviceFormFactor.
    //
    //  - UiRestriction.RESTRICTION_TYPE_TABLET
    //    Restricts the test to tablets as determined by DeviceFormFactor.
    value = {}
)
```

[**@MinAndroidSdkLevel**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/MinAndroidSdkLevel.java)
is similar to **@Restriction** in purpose in that it''s
intended to permanently limit a test to only recent versions of Android.

```java
@MinAndroidSdkLevel(
    // The minimum SDK level at which this test should be executed. Checks
    // against Build.VERSION.SDK_INT.
    value = 0
)
```

## Command-Line Flags Annotations

Several annotations affect how a test is run in interesting or nontrivial ways.

[**@CommandLineFlags.Add**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/CommandLineFlags.java#46)
and
[**@CommandLineFlags.Remove**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/CommandLineFlags.java#58)
manipulate Chrome''s
command-line flags on a per-test basis (i.e., the flags handled by
[`org.chromium.base.CommandLine`](https://chromium.googlesource.com/chromium/src/+/main/base/android/java/src/org/chromium/base/CommandLine.java) and
[`base::CommandLine`](https://chromium.googlesource.com/chromium/src/+/main/base/command_line.h)).

```java
@CommandLineFlags.Add(
    // The flags to add to the command line for this test. These can be
    // anything and typically should include the leading dashes (e.g. "--foo").
    value = {}
)

@CommandLineFlags.Remove(
    // The flags to remove from the command line for this test. These can only
    // be flags added via @CommandLineFlags.Add. Flags already present in the
    // command-line file on the device are only present in the native
    // CommandLine object and cannot be manipulated.
    value = {}
)
```

## Feature Annotations

[**@Feature**](https://chromium.googlesource.com/chromium/src/+/main/base/test/android/javatests/src/org/chromium/base/test/util/Feature.java)
has been used inconsistently in Chromium to group tests across
test cases according to the feature they''re testing.

```java
@Feature(
    // The features associated with this test. These can be anything.
    value = {}
)
```

@Feature doesn''t have an inherent function, but it can be used to filter tests
via the test runner''s
`-A/--annotation` and `-E/--exclude-annotation` flags. For example, this would
run only the tests with @Feature annotations containing at least "Sync" in
`chrome_public_test_apk`:

```bash
out/Debug/bin/run_chrome_public_test_apk -A Feature=Sync
```
', NULL, N'development', N'development/testing/android_instrumentation_tests', 1, GETDATE(), GETDATE(), 7);






























