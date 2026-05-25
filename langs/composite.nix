{ self, inputs, ... }: {
  flake.compositeShell = system: shellNames:
    (import inputs.nixpkgs { inherit system; }).mkShell {
      inputsFrom = map (name: self.devShells.${system}.${name}) shellNames;
    };
}
