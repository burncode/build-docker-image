BEGIN{
    cnt=0;print "Hest"
}
/ejendom.+7\.1/{
    cnt++
}
END{
    print cnt
}
