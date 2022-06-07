#! /bin/bash
  
#
# Author: Tucker Strand
#

print_usage () {
        echo " Usage: myuseradd.sh -a <login> <passwd> <shell>    Add a user account"
        echo "  myuseradd.sh -d <login>    Remove a user account"
        echo "  myuseradd.sh -h    Display this usage message"

}

delete_user () {
if grep -q $1 /etc/passwd
then
        sudo userdel -r $1
        echo "$1 is deleted"
else
        echo "ERROR: $1 does not exist"
fi
}

add_user () {
if grep -q $1 /etc/passwd
then
        echo "ERROR: $1 exists"
else
        useradd -m $1 -s $3
        echo "$2" | passwd --stdin "$1"
        echo "$1 ($2) with $3 is added "
fi
}



#}

case "$1" in
        -h)
                print_usage
        ;;
        -d)
                delete_user "$2"
        ;;
        -a)
                add_user "$2" "$3" "$4"
        ;;
        *)
                echo "ERROR: Ivalid option: $1"
                print_usage
        ;;
