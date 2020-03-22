require 'beaker/hypervisor/vagrant'

class Beaker::VagrantLibvirt < Beaker::Vagrant
  def provision(provider = 'libvirt')
    super
  end

  def self.provider_vfile_section(host, options)
    "    v.vm.provider :libvirt do |node|\n" +
      "      node.cpus = #{cpus(host, options)}\n" +
      "      node.memory = #{memsize(host, options)}\n" +
      "      node.qemu_use_session = false\n" +
      build_options(options).join("\n") + "\n" +
      "    end\n"
  end

  def self.build_options(options)
    return [] unless options['libvirt']

    options['libvirt'].map { |k, v| "      node.#{k} = '#{v}'" }
  end
end
