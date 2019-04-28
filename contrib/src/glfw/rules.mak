# GLFW 3.3
GLFW_GITURL := https://github.com/glfw/glfw


$(TARBALLS)/libglfw-git.tar.xz:
	$(call download_git,$(GLFW_GITURL), master, b0796109629931b6fa6e449c15a177845256a407)

#.sum-glfw: glfw-$(GLFW_VERSION).tar.gz

glfw: libglfw-git.tar.xz
	$(UNPACK)
	#$(APPLY) $(SRC)/glfw/fix-mac-os-10-12.patch
	$(APPLY) $(SRC)/glfw/dont_include_applicationservices.patch
	$(MOVE)

.glfw: glfw
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS) $(EX_ECFLAGS)"  cmake .  -DGLFW_BUILD_DOCS=0 -DGLFW_BUILD_EXAMPLES=0 -DGLFW_BUILD_TESTS=0 -DGLFW_VULKAN_STATIC=0 -DCMAKE_INSTALL_PREFIX=$(PREFIX)
	cd $< && $(MAKE) VERBOSE=1 install
	touch $@
