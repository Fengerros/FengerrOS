void function(){
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'A';
}

void main() {
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'B';

    function();
}