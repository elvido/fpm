require "backports" # gem backports
require "fpm/package"
require "fpm/util"
require "fileutils"
require "fpm/package/dir"

# Use a tarball as a package.
#
# This provides no metadata. Both input and output are supported.
class FPM::Package::Tar < FPM::Package

  # Input a tarball. Compressed tarballs should be OK.
  def input(input_path)
    # use part of the filename as the package name
    self.name = File.basename(input_path).split(".").first

    # Unpack the tarball to the build path before ultimately moving it to
    # staging.
    args = ["-xf", input_path, "-C", build_path]

    # Add the tar compression flag if necessary
<<<<<<< HEAD
    with(tar_compression_flag(input_path)) do |flag|
=======
    tar_compression_flag(input_path).tap do |flag|
>>>>>>> 40ec0c3576e02e7b8402df13185c8240adbd0e86
      args << flag unless flag.nil?
    end

    safesystem("tar", *args)

    # use dir to set stuff up properly, mainly so I don't have to reimplement
    # the chdir/prefix stuff special for tar.
    dir = convert(FPM::Package::Dir)
    if attributes[:chdir]
      dir.attributes[:chdir] = File.join(build_path, attributes[:chdir])
    else
      dir.attributes[:chdir] = build_path
    end

    cleanup_staging
    # Tell 'dir' to input "." and chdir/prefix will help it figure out the
    # rest.
    dir.input(".")
    @staging_path = dir.staging_path
    dir.cleanup_build
  end # def input

  # Output a tarball.
  #
  # If the output path ends predictably (like in .tar.gz) it will try to obey
  # the compression type.
  def output(output_path)
    output_check(output_path)
<<<<<<< HEAD
    # Unpack the tarball to the staging path
    args = ["-cf", output_path, "-C", staging_path]
    with(tar_compression_flag(output_path)) do |flag|
=======

    # Write the scripts, too.
    scripts_path = File.join(staging_path, ".scripts")
    ::Dir.mkdir(scripts_path)
    [:before_install, :after_install, :before_remove, :after_remove].each do |name|
      next unless script?(name)
      out = File.join(scripts_path, name.to_s)
      logger.debug("Writing script", :source => name, :target => out)
      File.write(out, script(name))
      File.chmod(0755, out)
    end

    # Unpack the tarball to the staging path
    args = ["-cf", output_path, "-C", staging_path]
    tar_compression_flag(output_path).tap do |flag|
>>>>>>> 40ec0c3576e02e7b8402df13185c8240adbd0e86
      args << flag unless flag.nil?
    end
    args << "."

    safesystem("tar", *args)
  end # def output

  # Generate the proper tar flags based on the path name.
  def tar_compression_flag(path)
    case path
      when /\.tar\.bz2$/
        return "-j"
      when /\.tar\.gz$|\.tgz$/
        return "-z"
      when /\.tar\.xz$/
        return "-J"
      else
        return nil
    end
  end # def tar_compression_flag
end # class FPM::Package::Tar
