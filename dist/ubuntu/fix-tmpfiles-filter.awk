/^.*systemd-tmpfiles\[[0-9]+\]:/ {
    match($0, /^.*(\/usr\/lib\/tmpfiles.d\/.*):.*updating.*(\/var\/run\/.*) . (.*);/, a);
    system("sed -i s+"a[2]"+"a[3]"+g "a[1]);
    }


