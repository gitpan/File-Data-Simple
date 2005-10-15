use Module::Build;
# See perldoc Module::Build for details of how this works

Module::Build->new
    ( module_name     => 'File::Data::Simple',
      license         => 'perl',
      requires        => {
          FileHandle => 0,
          Carp       => 0,
          perl       => '5.6.0',
      }
    )->create_build_script;
