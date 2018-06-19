class base {
	case $::osfamily{
		"redhat": {
			$pacotes = ["fish","epel-release","git","vim","sysstat","htop","sl","figlet","httpd"]
			
			service{"httpd":
				ensure => running,
				enable => true			
			}					
}

		"debian": {
			$pacotes = ["fish","git","vim","sysstat","htop","cowsay","sl","figlet","apache2"]
			
			service{"apache2":
				ensure => running,
				enable => true			
			}					

			exec{"Atualiza repos":
				command => "/usr/bin/apt update"	
			}
		}

	}

			service{"nginx":
				ensure => stopped,
				enable => false			
			}
					
	package{$pacotes:
		ensure => present
	
	}
		
	file{'/root/.bashrc':
		source => "puppet:///modules/base/bashrc_base",
		ensure => present
	}

	user{'devops':
		ensure => present,
		managehome => yes,
		shell => "/usr/bin/fish" 	
	}
}
