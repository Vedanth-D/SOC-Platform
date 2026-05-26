# Load standard Zeek scripts
@load base/protocols/conn
@load base/protocols/dns
@load base/protocols/ftp
@load base/protocols/http
@load base/protocols/smtp
@load base/protocols/ssh
@load base/protocols/ssl
@load base/frameworks/files
@load base/frameworks/notice
@load policy/tuning/json-logs

# Log all HTTP requests
@load policy/protocols/http/detect-sqli
@load policy/protocols/http/detect-webapps

# SSH detection
@load policy/protocols/ssh/detect-bruteforcing

# Intel framework
@load policy/frameworks/intel/seen
@load policy/frameworks/intel/do_notice

# Disable checksums (useful in VM/container environments)
redef ignore_checksums = T;

# Set log format to JSON
redef LogAscii::use_json = T;

# Define local networks
redef Site::local_nets = {
  192.168.0.0/16,
  10.0.0.0/8,
  172.16.0.0/12
};

# SSH brute force threshold
redef SSH::password_guesses_limit = 5;

# Log rotation interval
redef Log::default_rotation_interval = 1hr;