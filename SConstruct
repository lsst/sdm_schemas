# -*- python -*-
#
# Setup our environment
#
import glob, os.path, re, sys
import lsst.SConsUtils as scons

dependencies = ["python", "mysqlclient"]

env = scons.makeEnv("cat",
                    r"$HeadURL: svn+ssh://svn.lsstcorp.org/DMS/cat/base/trunk/SConstruct $",
                    [["python"],
                     ["mysqlclient"]
                    ])
env.Help("""
LSST Catalog package
""")

###############################################################################
# Boilerplate below here

pkg = env["eups_product"]
env.libs[pkg] += env.getlibs(" ".join(dependencies))

#
# Build/install things
#
for d in Split("sql bin pipeline lib python examples tests doc"):
    if d == "python":
        d = os.path.join(d, "lsst")
        for i in pkg.split("_"):
            d = os.path.join(d, i)
    if os.path.isdir(d) and os.path.isfile(os.path.join(d, "SConscript")):
        try:
            SConscript(os.path.join(d, "SConscript"))
        except Exception, e:
            print >> sys.stderr, "%s: %s" % (os.path.join(d, "SConscript"), e)

env['IgnoreFiles'] = r"(~$|\.pyc$|^\.svn$|\.o$)"

Alias("install", [env.Install(env['prefix'], "python"),
                  env.Install(env['prefix'], "bin"),
                  env.Install(env['prefix'], "sql"),
                  env.InstallEups(os.path.join(env['prefix'], "ups"))])

scons.CleanTree(r"*~ core *.so *.os *.o")

#
# Build TAGS files
#
files = scons.filesToTag()
if files:
    env.Command("TAGS", files, "etags -o $TARGET $SOURCES")

env.Declare()
