import { ApiProperty } from "@nestjs/swagger";

export class ViTriDto {
    @ApiProperty()
    ten_vi_tri: string;

    @ApiProperty()
    tinh_thanh: string;

    @ApiProperty()
    quoc_gia: string;
}

export class VitriImgDto {
    @ApiProperty({ type: 'array', items: { type: 'string', format: 'binary' } })
    files: any;
}