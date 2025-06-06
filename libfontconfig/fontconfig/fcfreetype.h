/*
 * $RCSId: xc/lib/fontconfig/fontconfig/fcfreetype.h,v 1.2 2002/02/15 06:01:27 keithp Exp $
 *
 * Copyright � 2001 Keith Packard
 *
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of Keith Packard not be used in
 * advertising or publicity pertaining to distribution of the software without
 * specific, written prior permission.  Keith Packard makes no
 * representations about the suitability of this software for any purpose.  It
 * is provided "as is" without express or implied warranty.
 *
 * KEITH PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
 * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
 * EVENT SHALL KEITH PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
 * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

#ifndef _FCFREETYPE_H_
#define _FCFREETYPE_H_

#include <ft2build.h>
#include FT_FREETYPE_H

FT_UInt
FcFreeTypeCharIndex (FT_Face face, FcChar32 ucs4);

FcCharSet *
FcFreeTypeCharSetAndSpacing (FT_Face face, FcBlanks *blanks, int *spacing);
    
FcCharSet *
FcFreeTypeCharSet (FT_Face face, FcBlanks *blanks);

FcResult
FcPatternGetFTFace (const FcPattern *p, const char *object, int n, FT_Face *f);

FcBool
FcPatternAddFTFace (FcPattern *p, const char *object, const FT_Face f);

#endif
