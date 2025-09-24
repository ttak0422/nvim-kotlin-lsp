_: final: _prev: {
  kotlin-lsp = final.stdenv.mkDerivation rec {
    pname = "kotlin-lsp";
    version = "0.253.10629";
    src = final.fetchzip {
      url = "https://download-cdn.jetbrains.com/kotlin-lsp/${version}/kotlin-${version}.zip";
      hash = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
      stripRoot = false;
    };
    dontBuild = true;
    nativeBuildInputs = with final; [ makeWrapper ];
    buildInputs = with final; [
      openjdk
      gradle
    ];
    installPhase = ''
      mkdir -p $out/libexec/kotlin-lsp $out/bin
      cp kotlin-lsp.sh $out/libexec/kotlin-lsp/
      cp -r lib native $out/libexec/kotlin-lsp/
    '';
    postFixup = ''
      makeWrapper ${final.bash}/bin/bash $out/bin/kotlin-lsp \
        --chdir $out/libexec/kotlin-lsp \
        --add-flags ./kotlin-lsp.sh \
        --set-default JAVA_HOME ${final.openjdk}
    '';
  };
}
