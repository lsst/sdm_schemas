install()
{
    default_install
    mkdir -p "$PREFIX"
    cp -a ./yml "$PREFIX"
    install_ups
}
