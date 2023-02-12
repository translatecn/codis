// Copyright 2016 CodisLabs. All Rights Reserved.
// Licensed under the MIT (MIT-LICENSE.txt) license.

//go:build cgo_jemalloc

package unsafe2

// jemalloc 它最大的优势在于多线程情况下的高性能以及内存碎片的减少
import (
	jemalloc "github.com/spinlock/jemalloc-go"
	"unsafe"
)

func cgo_malloc(n int) unsafe.Pointer {
	return jemalloc.Malloc(n)
}

func cgo_free(ptr unsafe.Pointer) {
	jemalloc.Free(ptr)
}
